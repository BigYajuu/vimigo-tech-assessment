import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'local_storage/db.dart';
import 'components/contact_containter.dart';
import 'local_storage/schema/contact_list.dart';
import 'dart:math';

final _rand = Random();

void main() {
  runApp(const Home());
}

const List<String> _nameList = [
  'Chan Saw Lin',
  'Lee Saw Loy',
  'Khaw Tong Lin',
  'Lim Kok Lin',
  'Low Jun Wei',
  'Yong Weng Kai',
  'Jayden Lee',
  'Kong Kah Yan',
  'Jasmine Lau'
];

const List<String> _phoneList = [
  '0152131113',
  '0161231346',
  '0158398109',
  '0168279101',
  '0112731912',
  '0172332743',
  '0191236439',
  '0111931233',
];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  late List<Contact> _contacts = [
    Contact(user: getAName(), phone: getAPhone(), checkIn: getACheckIn())
  ]; // Sets as state of all contacts (from db)
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _timeDispAgo = ValueNotifier(true);
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshContacts();

    // Configure time disp mode boolean
    getTimeDispAgo();
  }

  // Configure time disp mode boolean through sharedPref lookup
  Future getTimeDispAgo() async {
    final SharedPreferences prefs = await _prefs;
    bool? sPO = prefs.getBool("timeDispAgo"); // outcome of sharedPref

    // If sharedPref is null, set it for the first time.
    if (sPO == null) {
      prefs.setBool("timeDispAgo", true);
    } else {
      _timeDispAgo.value = sPO;
    }
  }

  // Flips the state of the time disp mode & also set it in sharedPref
  Future flipTimeDispAgo() async {
    final SharedPreferences prefs = await _prefs;
    bool? sPO = prefs.getBool("timeDispAgo"); // outcome of sharedPref

    // If sharedPref is null, set it for the first time.
    // Otherwise, flip the boolean
    if (sPO == null) {
      prefs.setBool("timeDispAgo", !_timeDispAgo.value);
    } else {
      prefs.setBool("timeDispAgo", !sPO);
    }
    _timeDispAgo.value = !_timeDispAgo.value;
  }

  // Followings are fns to get random data from
  String getAName() {
    int next = _rand.nextInt(_nameList.length);
    return _nameList[next];
  }

  String getAPhone() {
    int next = _rand.nextInt(_phoneList.length);
    return _phoneList[next];
  }

  DateTime getACheckIn() {
    const int range = 1200000;
    int next = _rand.nextInt(range);
    return DateTime.now().add(Duration(seconds: -next));
  }

  // Fetch all data from DB
  Future refreshContacts() async {
    setState((() => isLoading = true));
    _contacts = List.from(await ContactListDB.instance.getWholeList());
    setState((() => isLoading = false));
  }

  // Generate 5 random entries, stores them in DB, then refresh page
  Future generateContacts() async {
    const int reps = 5;

    // data generation
    for (var i = 0; i < reps; i++) {
      Contact newContact =
          Contact(user: getAName(), phone: getAPhone(), checkIn: getACheckIn());
      await ContactListDB.instance.create(newContact);
    }
    refreshContacts();
  }

  // Clear ContactList table data
  Future clearContactList() async {
    await ContactListDB.instance.clearWholeList();
    refreshContacts();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green,
              title: const Text('Contact List Management'),
            ),
            body: ValueListenableBuilder<bool>(
                valueListenable: _timeDispAgo,
                builder: (context, value, child) {
                  return Column(
                    children: [
                      Expanded(
                          child: isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : RefreshIndicator(
                                  onRefresh: generateContacts,
                                  child: ListView.builder(
                                      padding: const EdgeInsets.all(8),
                                      itemCount: _contacts.length,
                                      itemBuilder: (context, index) {
                                        return ContactContainer(
                                          contact: _contacts[index],
                                          isTimeDispAgo: _timeDispAgo,
                                        );
                                      }),
                                )),
                    ],
                  );
                }),
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(child: Container()),
                  // Float 1) Set SharedPref of time disp mode
                  FloatingActionButton(
                    onPressed: () {
                      flipTimeDispAgo();
                    },
                    backgroundColor: Colors.blueGrey[300],
                    child: const Icon(Icons.access_time),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Float 2) Clear all data in the DB
                  FloatingActionButton.extended(
                    onPressed: () {
                      clearContactList();
                    },
                    label: const Text('Clear Data'),
                    icon: const Icon(Icons.delete),
                    backgroundColor: Colors.redAccent,
                  ),
                ],
              ),
            )));
  }
}
