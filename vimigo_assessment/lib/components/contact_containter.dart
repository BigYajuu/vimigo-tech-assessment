import 'package:flutter/cupertino.dart';
import 'package:vimigo_assessment/local_storage/schema/contact_list.dart';

// A single contact item that is to be placed inside of the ListView
class ContactContainer extends StatelessWidget {
  final Contact contact;

  const ContactContainer({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0), child: Text(contact.user));
  }
}
