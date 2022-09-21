import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vimigo_assessment/local_storage/schema/contact_list.dart';

// A single contact item that is to be placed inside of the ListView
class ContactContainer extends StatelessWidget {
  final Contact contact;

  const ContactContainer({super.key, required this.contact});

  String getCheckInDisplay() {
    final f = DateFormat('yyyy-MM-dd hh:mm:ss');
    return f.format(contact.checkIn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 5), // changes position of shadow
          ),
        ],
      ),
      // The content within the box
      child: Column(
        children: [
          // Row 1) Display name and time stat
          Row(children: [
            // Cell 1) Display name
            Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    text: contact.user,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                )),
            // Cell 2) Display time stat to the right
            // Time display mode depends on the setting.
            Expanded(
                child: Align(
                    alignment: Alignment.centerRight,
                    child: RichText(
                      text: TextSpan(
                        text: getCheckInDisplay(),
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    )))
          ]),
          // Row 2) Display phone number
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                text: contact.phone,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
