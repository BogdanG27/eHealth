import 'Name.dart';

class Patient {
  final String oid;
  final String resourceType;
  final String id;
  final bool active;
  final List<Name> name;
  final String gender;

  Patient({
    required this.oid,
    required this.resourceType,
    required this.id,
    required this.active,
    required this.name,
    required this.gender,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      oid: json["_id"]['\$oid'],
      resourceType: json['resourceType'],
      id: json['id'],
      active: json['active'],
      name: (json['name'] as List<dynamic>)
          .map((nameJson) => Name.fromJson(nameJson))
          .toList(),
      gender: json['gender'],
    );
  }
}
