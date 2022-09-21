// Table name for Contact DB
const String tableContactList = 'contact_list';

class ContactFields {
  static final List<String> values = [id, user, phone, checkIn];

  static const String id = '_id';
  static const String user = 'user';
  static const String phone = 'phone';
  static const String checkIn = 'checkIn';
}

// Contact instances are universal for representing individual contact,
// It also features converting to/from JSON whenever DB is involved.
class Contact {
  final int? id;
  final String user;
  final String phone;
  final DateTime checkIn;

  const Contact({
    this.id,
    required this.user,
    required this.phone,
    required this.checkIn,
  });

  static Contact fromJson(Map<String, Object?> json) => Contact(
        id: json[ContactFields.id] as int?,
        user: json[ContactFields.user] as String,
        phone: json[ContactFields.phone] as String,
        checkIn: DateTime.parse(json[ContactFields.checkIn] as String),
      );

  Map<String, Object?> toJson() => {
        ContactFields.id: id,
        ContactFields.user: user,
        ContactFields.phone: phone,
        ContactFields.checkIn: checkIn.toIso8601String(),
      };

  Contact copy({
    int? id,
    String? user,
    String? phone,
    DateTime? checkIn,
  }) =>
      Contact(
        id: id ?? this.id,
        user: user ?? this.user,
        phone: phone ?? this.phone,
        checkIn: checkIn ?? this.checkIn,
      );
}
