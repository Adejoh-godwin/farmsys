class Imagemodel {
  final int id;
  final String imageurl;
  final String status;
  static const String TABLENAME = "farmers";

  Imagemodel({this.id, this.imageurl,this.status});

  Map<String, dynamic> toMap() {
    return {'id': id, 'imageurl': imageurl, 'status':status};
  }
}
