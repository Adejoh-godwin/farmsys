class Kinmodel {
  final int id;
  final String name;
  final String phone;
  final String kinname;
  final String kinphone;
  final String kindob;
  final String kinrelationship;
  final String kinaddress;

  static const String TABLENAME = "farmers";

  Kinmodel({
    this.kinname,
    this.kinphone,
    this.kindob,
    this.kinrelationship,
    this.kinaddress,
    this.id,
    this.name,
    this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'kinname': kinname,
      'kinphone': kinphone,
      'kindob': kindob,
      'kinrelationship': kinrelationship,
      'kinaddress': kinaddress
    };
  }
}
