import 'dart:convert';
import 'dart:io';
import 'package:farmsys/src/src/models/employee_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ViewDetails extends StatefulWidget {
  static const routeName = '/ViewDetails';
  final Farmerdata models;

  const ViewDetails({Key key, this.models}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreateTodoState(models);
}

class _CreateTodoState extends State<ViewDetails> {
  Farmerdata models;
  int id;
  String applicantbvn;
  String applicantgender;
  String fnpk;
  String furea;
  String forganic;
  String micronutrient;
  String knapsack;
  String insecticide;
  String hlagon;
  String hnsco;
  String latitude;
  String flat;
  String longitude;
  String flong;
  String hectaredistance;
  String imageurl;
  bool visible = false;
  File file;
  String productId = DateTime.now().millisecondsSinceEpoch.toString();

  _CreateTodoState(this.models);

  @override
  void initState() {
    super.initState();

    if (models != null) {
      id = models.id;
      fnpk = models.fnpk;
      furea = models.furea;
      forganic = models.forganic;
      micronutrient = models.micronutrient;
      knapsack = models.knapsack;
      insecticide = models.insecticide;
      hlagon = models.hlagon;
      hnsco = models.hnsco;
      hectaredistance = models.hectaredistance;
      latitude = models.latitude;
      longitude = models.longitude;
      flat = models.flat;
      flong = models.flong;
    }
  }

  Future webCall() async {
    // Showing Alert Dialog with Response JSON.

    // if (file == null) {
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: new Text("Please select an Image"),
    //         actions: <Widget>[
    //           FlatButton(
    //             child: new Text("OK"),
    //             onPressed: () {
    //               Navigator.pop(context);
    //               takeImage(context);
    //             },
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // } else {
    // imageurl = await uploadItemImage(file);
    showDialog(
        context: context,
        builder: (c) {
          return Center(
            child: SpinKitChasingDots(
              color: Colors.lightGreenAccent,
              size: 50.0,
            ),
          );
        });
    //}
    // API URL
    var url = 'https://hdtechng.com/insertdata.php';

    // Store all data with Param Name.
    var data = {
      'id': models.id,
      'applicantbvn': models.applicantbvn,
      'applicantfirstname': models.applicantfirstname,
      'applicantlastname': models.applicantlastname,
      'applicantmiddlename': models.applicantmiddlename,
      'applicantgender': models.applicantgender,
      'occupation': models.occupation,
      'spousebvn': models.spousebvn,
      'maritalstatus': models.maritalstatus,
      'address': models.address,
      'city': models.city,
      'lgacode': models.lgacode,
      'lganame': models.lganame,
      'statecode': models.statecode,
      'state': models.state,
      'nokbvn': models.nokbvn,
      'nokrelationship': models.nokrelationship,
      'latitude': models.latitude.toString(),
      'longitude': models.longitude.toString(),
      'flat': models.flat.toString(),
      'flong': models.flong.toString(),
      'hectaredistance': models.hectaredistance.toString(),
      'fnpk': models.fnpk,
      'furea': models.furea,
      'forganic': models.forganic,
      'micronutrient': models.micronutrient,
      'knapsack': models.knapsack,
      'insecticide': models.insecticide,
      'hlagon': models.hlagon,
      'hnsco': models.hnsco
    };

    // Starting Web Call with data.
    var response = await http.post(url, body: json.encode(data));

    // Getting Server response into variable.
    // ignore: unused_local_variable
    var message = jsonDecode(response.body);

    // If Web call Success than Hide the CircularProgressIndicator.
    if (response.statusCode == 200) {
      setState(() {
        visible = false;
      });
    }

    // DatabaseHelper.instance.deleteTodo(id);
    Navigator.pop(context);
    displayToastMessage("Data has been uploaded", context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Farmer\'s details'),
        ),
        body: ListView(padding: const EdgeInsets.all(16.0), children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 10.0),
              Card(
                elevation: 0.5,
                margin: const EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 0,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 200,
                      child: Stack(
                        children: [
                          imageurl != null
                              ? Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  child: Image.network(
                                    "assets/images/profiledefault.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  child: Image.asset(
                                    "assets/images/profiledefault.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                          file != null
                              ? Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  child: Image.file(
                                    file,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(),
                          Align(
                            alignment: Alignment(0, 0.8),
                            child: MaterialButton(
                              minWidth: 0,
                              elevation: 0.5,
                              color: Colors.white,
                              child: Icon(
                                Icons.add_a_photo,
                                color: Colors.green,
                                size: 60,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              onPressed: () {
                                //takeImage(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Text(
                        models.applicantlastname +
                            " " +
                            models.applicantfirstname,
                      ),
                      onTap: () {},
                    ),
                    _buildDivider(),
                    Text("BVN: " + models.applicantbvn,
                        style: TextStyle(
                            fontSize: 15.0, height: 3.0, color: Colors.black)),
                  ],
                ),
              ),
              Card(
                margin: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 0,
                ),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10, 3, 0, 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Personal Info",
                                style: TextStyle(
                                    fontSize: 19.0,
                                    height: 2.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ],
                        ),
                      ),
                    ),
                    _buildDivider(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(25, 3, 0, 8),
                        child: Text("Gender: ${models.applicantgender}",
                            style: TextStyle(
                                fontSize: 15.0,
                                height: 2.0,
                                color: Colors.black)),
                      ),
                    ),
                    _buildDivider(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(25, 3, 0, 8),
                        child: Text("State: ${models.state}",
                            style: TextStyle(
                                fontSize: 15.0,
                                height: 2.0,
                                color: Colors.black)),
                      ),
                    ),
                    _buildDivider(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(25, 3, 0, 8),
                        child: Text("LGA: ${models.lganame}",
                            style: TextStyle(
                                fontSize: 15.0,
                                height: 2.0,
                                color: Colors.black)),
                      ),
                    ),
                    _buildDivider(),
                    Text("Next Of Kin Info",
                        style: TextStyle(
                            fontSize: 19.0,
                            height: 2.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    _buildDivider(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(25, 3, 0, 8),
                        child: Text("BVN : ${models.nokbvn}",
                            style: TextStyle(
                                fontSize: 15.0,
                                height: 2.0,
                                color: Colors.black)),
                      ),
                    ),
                    _buildDivider(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(25, 3, 0, 8),
                        child: Text("Relationship: ${models.nokrelationship}",
                            style: TextStyle(
                                fontSize: 15.0,
                                height: 2.0,
                                color: Colors.black)),
                      ),
                    ),
                    _buildDivider(),
                    Text("Input Distribution Info",
                        style: TextStyle(
                            fontSize: 19.0,
                            height: 2.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(25, 3, 0, 8),
                        child: Text("Fertilizer (NPK) : $fnpk",
                            style: TextStyle(
                                fontSize: 15.0,
                                height: 2.0,
                                color: Colors.black)),
                      ),
                    ),
                    _buildDivider(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(25, 3, 0, 8),
                        child: Text("Fertilizer (UREA) : $furea",
                            style: TextStyle(
                                fontSize: 15.0,
                                height: 2.0,
                                color: Colors.black)),
                      ),
                    ),
                    _buildDivider(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(25, 3, 0, 8),
                        child: Text("Fertilizer (Organic) : $forganic",
                            style: TextStyle(
                                fontSize: 15.0,
                                height: 2.0,
                                color: Colors.black)),
                      ),
                    ),
                    _buildDivider(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(25, 3, 0, 8),
                        child: Text("Micro Nutrient : $micronutrient",
                            style: TextStyle(
                                fontSize: 15.0,
                                height: 2.0,
                                color: Colors.black)),
                      ),
                    ),
                    _buildDivider(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(25, 3, 0, 8),
                        child: Text("Knapsack Sprayer : $knapsack",
                            style: TextStyle(
                                fontSize: 15.0,
                                height: 2.0,
                                color: Colors.black)),
                      ),
                    ),
                    _buildDivider(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(25, 3, 0, 8),
                        child: Text("Insecticide : $insecticide",
                            style: TextStyle(
                                fontSize: 15.0,
                                height: 2.0,
                                color: Colors.black)),
                      ),
                    ),
                    _buildDivider(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(25, 3, 0, 8),
                        child: Text("Herbicide Lagon : $hlagon",
                            style: TextStyle(
                                fontSize: 15.0,
                                height: 2.0,
                                color: Colors.black)),
                      ),
                    ),
                    _buildDivider(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(25, 3, 0, 8),
                        child: Text("Herbicide Niscofulron : $hnsco",
                            style: TextStyle(
                                fontSize: 15.0,
                                height: 2.0,
                                color: Colors.black)),
                      ),
                    ),
                    _buildDivider(),
                    Text("Mapping Info",
                        style: TextStyle(
                            fontSize: 19.0,
                            height: 2.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(25, 3, 0, 8),
                        child: Text(
                            "Hectare Distance : $hectaredistance hectares",
                            style: TextStyle(
                                fontSize: 15.0,
                                height: 2.0,
                                color: Colors.black)),
                      ),
                    ),
                    _buildDivider(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(25, 3, 0, 8),
                        child: Text("Longitude : $longitude",
                            style: TextStyle(
                                fontSize: 15.0,
                                height: 2.0,
                                color: Colors.black)),
                      ),
                    ),
                    _buildDivider(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(25, 3, 0, 8),
                        child: Text("Latitude : $latitude",
                            style: TextStyle(
                                fontSize: 15.0,
                                height: 2.0,
                                color: Colors.black)),
                      ),
                    ),
                    _buildDivider(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(25, 3, 0, 8),
                        child: Text("Final Longitude : $flong",
                            style: TextStyle(
                                fontSize: 15.0,
                                height: 2.0,
                                color: Colors.black)),
                      ),
                    ),
                    _buildDivider(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(25, 3, 0, 8),
                        child: Text("Final Latitude : $flat",
                            style: TextStyle(
                                fontSize: 15.0,
                                height: 2.0,
                                color: Colors.black)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 18,
                  ),
                  RaisedButton(
                    elevation: 4,
                    color: Colors.lightGreen,
                    textColor: Colors.white,
                    onPressed: () {
                      webCall();
                    },
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                    child: Text('Upload to servers'),
                  ),
                ],
              ),
              const SizedBox(height: 60.0),
            ],
          ),
        ]));
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade300,
    );
  }

  // takeImage(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return SimpleDialog(
  //           title: Text(
  //             "Item Image",
  //             style:
  //                 TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
  //           ),
  //           children: [
  //             SimpleDialogOption(
  //               child: Text(
  //                 "Capture with camera",
  //                 style: TextStyle(
  //                     fontWeight: FontWeight.bold, color: Colors.green),
  //               ),
  //               onPressed: captureWithCamera,
  //             ),
  //             SimpleDialogOption(
  //               child: Text(
  //                 "Select from gallery",
  //                 style: TextStyle(
  //                     fontWeight: FontWeight.bold, color: Colors.green),
  //               ),
  //               onPressed: pickPhotFromGallery,
  //             ),
  //             SimpleDialogOption(
  //               child: Text(
  //                 "Cancel",
  //                 style: TextStyle(
  //                     fontWeight: FontWeight.bold, color: Colors.green),
  //               ),
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //             ),
  //           ],
  //         );
  //       });
  // }

  // pickPhotFromGallery() async {
  //   Navigator.pop(context);
  //   File imageFile = await ImagePicker.pickImage(
  //       source: ImageSource.gallery, maxHeight: 600.0, maxWidth: 970.0);
  //   setState(() {
  //     file = imageFile;
  //     imageurl = "imageFile";
  //   });
  // }

  // captureWithCamera() async {
  //   Navigator.pop(context);
  //   File imageFile = await ImagePicker.pickImage(
  //       source: ImageSource.camera, maxHeight: 600.0, maxWidth: 970.0);
  //   setState(() {
  //     file = imageFile;
  //   });
  //   print(file);
  // }

  // Future<String> uploadItemImage(File mfile) async {
  //   final StorageReference storageReference =
  //       FirebaseStorage.instance.ref().child("Items");
  //   StorageUploadTask storageUploadTask =
  //       storageReference.child('farmer_$productId.jpg').putFile(mfile);

  //   StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;

  //   String downloadUrl = await taskSnapshot.ref.getDownloadURL();
  //   return downloadUrl;
  // }

  displayToastMessage(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }
}
