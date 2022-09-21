import 'package:flutter/cupertino.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vimigo_assessment/local_storage/schema/contact_list.dart';

// A single contact item that is to be placed inside of the ListView
class ContactContainer extends StatefulWidget {
  final Contact contact;
  final ValueListenable<bool> isTimeDispAgo;

  const ContactContainer(
      {super.key, required this.contact, required this.isTimeDispAgo});

  @override
  _ContactContainerState createState() => _ContactContainerState();
}

class _ContactContainerState extends State<ContactContainer> {
  // Returns the string display for time.
  // There are 2 modes of display:
  // F) Normal date time format
  // T) In mode of '-- ago'
  // Refers to shared pref for user setting on the format
  // Value is found from a common Listenable variable set on the home page
  String getCheckInDisplay() {
    // print(widget.isTimeDispAgo.value);
    if (widget.isTimeDispAgo.value) {
      return timeago.format(widget.contact.checkIn);
    } else {
      return DateFormat('yyyy-MM-dd hh:mm:ss').format(widget.contact.checkIn);
    }
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
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 5), // changes position of shadow
          ),
        ],
      ),
      // The content within the box
      child: Column(children: [
        // Row 1) Display name and time stat
        Row(children: [
          // Cell 1) Display name
          Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  text: widget.contact.user,
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
        Row(
          children: [
            // Cell 1) Display phone number
            Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  text: widget.contact.phone,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
