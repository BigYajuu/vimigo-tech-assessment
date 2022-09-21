import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:vimigo_assessment/local_storage/schema/contact_list.dart';

class ContactListDB {
  static final ContactListDB instance = ContactListDB._init();

  static Database? _database;

  ContactListDB._init();

  static const contactListFilePath = 'contact_list.db';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  // Initializing the DB
  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, contactListFilePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // Creating the DB for the first time
  Future _createDB(Database db, int version) async {
    const idRule = 'INTEGER PRIMARY KEY AUTOINCREMENT';

    await db.execute('''CREATE TABLE $tableContactList (
        ${ContactFields.id} $idRule,
        ${ContactFields.user},
        ${ContactFields.phone},
        ${ContactFields.checkIn}
      )''');
  }

  // Delete the DB
  void _deleteDB() async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, contactListFilePath);
    databaseFactory.deleteDatabase(path);
    _database = null;
  }

  // CRUD
  Future<Contact> create(Contact newContact) async {
    final db = await instance.database;

    final id = await db.insert(tableContactList, newContact.toJson());
    return newContact.copy(id: id);
  }

  Future<List<Contact>> getWholeList() async {
    final db = await instance.database;

    // get all rows
    final queriedJsonList = await db.query(tableContactList,
        orderBy: '${ContactFields.checkIn} ASC');

    List<Contact> queriedInstances = [];
    if (queriedJsonList.isNotEmpty) {
      // all convert to json
      for (var eachJson in queriedJsonList) {
        {
          queriedInstances.add(Contact.fromJson(eachJson));
        }
      }
    }
    return queriedInstances;
  }

  // Closing the DB
  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
