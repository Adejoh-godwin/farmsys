class Book {
  final dynamic id;
  final dynamic applicantbvn;
  final dynamic applicantfirstname;
  final dynamic applicantmiddlename;
  final dynamic applicantlastname;
  final dynamic applicantgender;
  final dynamic occupation;
  final dynamic maritalstatus;
  final dynamic spousebvn;
  final dynamic address;
  final dynamic city;
  final dynamic lgacode;
  final dynamic lganame;
  final dynamic statecode;
  final dynamic state;
  final dynamic nokbvn;
  final dynamic nokrelationship;
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
  final String status;
  final String hectaredistance;

  const Book(
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
      this.latitude1,
      this.flat,
      this.flong,
      this.longitude1,
      this.hectaredistance,
      this.status});

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json['id'],
        applicantbvn: json['applicantbvn'].toString(),
        applicantfirstname: json['applicantfirstname'],
        applicantmiddlename: json['applicantmiddlename'],
        applicantlastname: json['applicantlastname'],
        applicantgender: json['applicantgender'],
        occupation: json['occupation'],
        maritalstatus: json['maritalstatus'],
        spousebvn: json['spousebvn'],
        address: json['address'],
        city: json['city'],
        lgacode: json['lgacode'],
        lganame: json['lganame'],
        statecode: json['statecode'],
        nokbvn: json['nokbvn'].toString(),
        nokrelationship: json['nokrelationship'],
        state: json['state'],
        fnpk: json['fnpk'],
        furea: json['state'],
        forganic: json['forganic'],
        micronutrient: json['micronutrient'],
        knapsack: json['knapsack'],
        insecticide: json['insecticide'],
        hlagon: json['hlagon'],
        hnsco: json['hnsco'],
        latitude1: json['latitude1'].toString(),
        flat: json['flat'].toString(),
        flong: json['flong'].toString(),
        longitude1: json['longitude1'].toString(),
        hectaredistance: json['hectaredistance'].toString(),
        status: json['status'],
      );

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
        'latitude1': latitude1,
        'longitude1': longitude1,
        'flong': flong,
        'flat': flat,
        'hectaredistance': hectaredistance,
        'status': status,
      };
}
