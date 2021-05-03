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

class Farmerdata {
  dynamic id;
  dynamic applicantbvn;
  dynamic applicantfirstname;
  dynamic applicantmiddlename;
  dynamic applicantlastname;
  dynamic applicantgender;
  dynamic occupation;
  dynamic maritalstatus;
  dynamic spousebvn;
  dynamic address;
  dynamic city;
  dynamic lgacode;
  dynamic lganame;
  dynamic statecode;
  dynamic state;
  dynamic nokbvn;
  dynamic nokrelationship;
  final String fnpk;
  final String furea;
  final String forganic;
  final String micronutrient;
  final String knapsack;
  final String insecticide;
  final String hlagon;
  final String hnsco;
  final String latitude;
  final String flat;
  final String longitude;
  final String flong;
  final String status;
  final String hectaredistance;
  static const String TABLENAME = "farmers";

  Farmerdata(
      {this.id,
      this.applicantbvn,
      this.applicantfirstname,
      this.applicantmiddlename,
      this.applicantlastname,
      this.applicantgender,
      this.occupation,
      this.maritalstatus,
      this.spousebvn,
      this.address,
      this.city,
      this.lgacode,
      this.lganame,
      this.statecode,
      this.state,
      // ignore: nonconstantidentifiernames
      this.nokbvn,
      // ignore: nonconstantidentifiernames
      this.nokrelationship,
      this.fnpk,
      this.furea,
      this.forganic,
      this.micronutrient,
      this.knapsack,
      this.insecticide,
      this.hlagon,
      this.hnsco,
      this.latitude,
      this.flat,
      this.flong,
      this.longitude,
      this.hectaredistance,
      this.status});

  factory Farmerdata.fromJson(Map<String, dynamic> json) {
    return Farmerdata(
      id: json['id'],
      applicantbvn: json['applicantbvn'].toString(),
      applicantfirstname: json['applicantfirstname'],
      applicantmiddlename: json['applicantmiddlename'],
      applicantlastname: json['applicantlastname'],
      applicantgender: json['applicantgender'],
      occupation: json['occupation'],
      maritalstatus: json['maritalstatus'],
      spousebvn: json['spousebvn'].toString(),
      address: json['address'],
      city: json['city'],
      lgacode: json['lgacode'].toString(),
      lganame: json['lganame'],
      statecode: json['statecode'].toString(),
      nokbvn: json['nokbvn'].toString(),
      nokrelationship: json['nokrelationship'],
      state: json['state'].toString(),
      fnpk: json['fnpk'].toString(),
      furea: json['furea'].toString(),
      forganic: json['forganic'],
      micronutrient: json['micronutrient'],
      knapsack: json['knapsack'],
      insecticide: json['insecticide'],
      hlagon: json['hlagon'],
      hnsco: json['hnsco'],
      latitude: json['latitude'].toString(),
      flat: json['flat'].toString(),
      flong: json['flong'].toString(),
      longitude: json['longitude'].toString(),
      hectaredistance: json['hectaredistance'].toString(),
      status: json['status'],
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "applicantbvn": applicantbvn,
        "applicantfirstname": applicantfirstname,
        "applicantmiddlename": applicantmiddlename,
        "applicantlastname": applicantlastname,
        "applicantgender": applicantgender,
        "occupation": occupation,
        "maritalstatus": maritalstatus,
        "spousebvn": spousebvn,
        "address": address,
        "city": city,
        "lgacode": lgacode,
        "lganame": lganame,
        "statecode": statecode,
        "nokbvn": nokbvn,
        "nokrelationship": nokrelationship,
        "state": state,
        'fnpk': fnpk,
        'furea': furea,
        'forganic': forganic,
        'knapsack': knapsack,
        'micronutrient': micronutrient,
        'insecticide': insecticide,
        'hlagon': hlagon,
        'hnsco': hnsco,
        'latitude': latitude,
        'longitude': longitude,
        'flong': flong,
        'flat': flat,
        'hectaredistance': hectaredistance,
        'status': status,
      };

  Map<String, dynamic> toJson2() => {
        'latitude': latitude,
        'longitude': longitude,
        'flong': flong,
        'flat': flat,
        'hectaredistance': hectaredistance,
      };
}
