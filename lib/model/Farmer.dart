class Farmer {
  final int id;
  final String name;
  final String phone;
  final String boa;
  final String gender;
  final String lga;
  final String location;
  final String state;
  final String ward;
  final String cooperative;
  final String dob;
  final String kinname;
  final String kinphone;
  final String kindob;
  final String kinrelationship;
  final String kinaddress;
  static const String TABLENAME = "farmers";

  Farmer({
    this.id,
    this.name,
    this.phone,
    this.boa,
    this.gender,
    this.lga,
    this.location,
    this.state,
    this.ward,
    this.cooperative,
    this.dob,
    this.kinname,
    this.kinphone,
    this.kindob,
    this.kinrelationship,
    this.kinaddress,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'boa': boa,
      'gender': gender,
      'lga': lga,
      'location': location,
      'state': state,
      'ward': ward,
      'cooperative': cooperative,
      'dob': dob,
      'kinname': kinname,
      'kinphone': kinphone,
      'kindob': kindob,
      'kinrelationship': kinrelationship,
      'kinaddress': kinaddress
    };
  }
}
