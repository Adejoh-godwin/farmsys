class Onlinemodel {
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
  final String fnpk;
  final String furea;
  final String forganic;
  final String micronutrient;
  final String knapsack;
  final String insecticide;
  final String hlagon;
  final String hnsco;
  final String latitude1;
  final String flat;
  final String longitude1;
  final String flong;
  final String imageurl;
  final String status;

  final String hectaredistance;
  static const String TABLENAME = "farmers";

  Onlinemodel(
      {this.id,
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
      this.fnpk,
      this.furea,
      this.forganic,
      this.micronutrient,
      this.knapsack,
      this.insecticide,
      this.hlagon,
      this.hnsco,
      this.latitude1,
      this.flat,
      this.flong,
      this.longitude1,
      this.hectaredistance,
      this.imageurl,
      this.status});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'imageurl': imageurl,
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
      'kinaddress': kinaddress,
      'fnpk': fnpk,
      'furea': furea,
      'forganic': forganic,
      'knapsack': knapsack,
      'micronutrient': micronutrient,
      'insecticide': insecticide,
      'hlagon': hlagon,
      'hnsco': hnsco,
      'latitude1': latitude1,
      'longitude1': longitude1,
      'longitude2': flong,
      'latitude2': flat,
      'hectaredistance': hectaredistance,
      'status': status,
    };
  }
}
