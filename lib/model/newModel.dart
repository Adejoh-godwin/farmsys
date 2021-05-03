import 'dart:convert';

List<Employee> employeeFromJson(String str) =>
    List<Employee>.from(json.decode(str).map((x) => Employee.fromJson(x)));

String employeeToJson(List<Employee> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Employee {
  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  Employee({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "avatar": avatar,
      };
}

class Studentdata {
  final int id;
  final dynamic name;
  final dynamic phone;
  final dynamic state;
  final dynamic gender;
  final dynamic lga;
  final dynamic location;

  static const String TABLENAME = "farmers";

  Studentdata({
    this.id,
    this.name,
    this.phone,
    this.gender,
    this.lga,
    this.location,
    this.state,
  });

  factory Studentdata.fromJson(Map<String, dynamic> json) {
    return Studentdata(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      state: json['state'],
      lga: json['lga'],
      gender: json['gender'],
      location: json['location'],
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'location': location,
        'gender': gender,
        'lga': lga,
        'state': state,
      };
}
