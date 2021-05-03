class Mapmodel {
  final int id;
  final String name;
  final String phone;
  final dynamic latitude1;
  final dynamic flat;
  final dynamic longitude1;
  final dynamic flong;
  final dynamic hectaredistance;
  static const String TABLENAME = "farmers";

  Mapmodel({
    this.id,
    this.name,
    this.phone,
    this.latitude1,
    this.flat,
    this.longitude1,
    this.flong,
    this.hectaredistance,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'latitude1': latitude1,
      'longitude1': longitude1,
      'flong': flong,
      'flat': flat,
      'hectaredistance': hectaredistance
    };
  }
}
