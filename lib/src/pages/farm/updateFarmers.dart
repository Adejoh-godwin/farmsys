import 'package:farmsys/src/src/models/employee_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'nextOfKin.dart';

class SecondScreenState extends StatefulWidget {
  final String idHolder;
  SecondScreenState(this.idHolder);
  @override
  State<StatefulWidget> createState() {
    return SecondScreen(this.idHolder);
  }
}

class SecondScreen extends State<SecondScreenState> {
  final String idHolder;
  File file;

  final nameController = TextEditingController();
  final bvnController = TextEditingController();
  final idController = TextEditingController();
  final genderController = TextEditingController();
  final lgaController = TextEditingController();
  final addressController = TextEditingController();
  final stateController = TextEditingController();
  final maritalController = TextEditingController();
  final occupationController = TextEditingController();
  final spouseBvnController = TextEditingController();

  String productId = DateTime.now().millisecondsSinceEpoch.toString();

  bool uploading = false;

  SecondScreen(this.idHolder);

  // API URL
  var url = 'https://hdtechng.com/fetch.php';

  Future<List<Farmerdata>> fetchStudent() async {
    var data = {'id': int.parse(idHolder)};

    var response = await http.post(url, body: json.encode(data));

    if (response.statusCode == 200) {
      print(response.statusCode);

      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<Farmerdata> studentList = items.map<Farmerdata>((json) {
        return Farmerdata.fromJson(json);
      }).toList();

      return studentList;
    } else {
      throw Exception('Failed to load data from Server.');
    }
  }

  // Boolean variable for CircularProgressIndicator.
  bool visible = false;

  // Future webCall() async {
  //   var imageDownloadUrl;
  //   // Showing CircularProgressIndicator using State.
  //   setState(() {
  //     visible = true;
  //   });
  //   if (visible == true) {
  //     showDialog(
  //         context: context,
  //         builder: (c) {
  //           return Center(
  //             child: SpinKitChasingDots(
  //               color: Colors.lightGreenAccent,
  //               size: 50.0,
  //             ),
  //           );
  //         });
  //   }

  //   // Getting value from Controller
  //   if (file != null) {
  //     imageDownloadUrl = await uploadItemImage(file);
  //   } else {
  //     imageDownloadUrl = 'empty';
  //   }

  //   String farmername = nameController.text;
  //   String bvn = bvnController.text;
  //   int id = int.parse(idHolder);
  //   String lga = lgaController.text;
  //   String state = stateController.text;
  //   String location = addressController.text;

  //   String gender = genderController.text;
  //   String spouseBvn = spouseBvnController.text;
  //   String occupation = occupationController.text;
  //   String maritalStatus = maritalController.text;

  //   // API URL
  //   var url = 'https://hdtechng.com/updateDetails.php';

  //   // Store all data with Param Name.
  //   var data = {
  //     'id': id,
  //     'name': farmername,
  //     'bvn': bvn,
  //     'gender': gender,
  //     'state': state,
  //     'address': location,
  //     'occupation': occupation,
  //     'maritalStatus': maritalStatus,
  //     'spouseBvn': spouseBvn,
  //     'lga': lga,
  //     'image': imageDownloadUrl
  //   };

  //   // Starting Web Call with data.
  //   var response = await http.post(url, body: json.encode(data));

  //   // Getting Server response into variable.
  //   var message = jsonDecode(response.body);

  //   // If Web call Success than Hide the CircularProgressIndicator.
  //   if (response.statusCode == 200) {
  //     Navigator.pop(context);
  //     setState(() {
  //       visible = false;
  //     });
  //   }

  //   // Showing Alert Dialog with Response JSON.
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: new Text(message),
  //         actions: <Widget>[
  //           FlatButton(
  //             child: new Text("OK"),
  //             onPressed: () {
  //               Navigator.pushReplacement(context,
  //                   MaterialPageRoute(builder: (context) => Kin(idHolder)));
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.lightGreen,
                title: Text('Showing Details of farmer'),
                automaticallyImplyLeading: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context, false),
                )),
            body: FutureBuilder<List<Farmerdata>>(
              future: fetchStudent(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());

                return ListView(
                  children: snapshot.data
                      .map((data) => Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    TextField(
                                      readOnly: true,
                                      controller: nameController
                                        ..text = data.applicantlastname +
                                            " " +
                                            data.applicantfirstname,
                                      decoration: InputDecoration(
                                        labelText: "Farmer's Name",
                                      ),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    TextField(
                                      readOnly: true,
                                      controller: bvnController
                                        ..text = data.applicantbvn.toString(),
                                      decoration: InputDecoration(
                                        labelText: "BVN",
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    TextField(
                                      controller: genderController
                                        ..text =
                                            data.applicantgender.toString(),
                                      decoration: InputDecoration(
                                        labelText: "Gender",
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    TextField(
                                      controller: occupationController
                                        ..text = data.occupation.toString(),
                                      decoration: InputDecoration(
                                        labelText: "Occupation",
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    TextField(
                                      controller: maritalController
                                        ..text = data.maritalstatus.toString(),
                                      decoration: InputDecoration(
                                        labelText: "Marital Status",
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    TextField(
                                      controller: spouseBvnController
                                        ..text = data.applicantbvn.toString(),
                                      decoration: InputDecoration(
                                        labelText: "Spouse Bvn",
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    TextField(
                                      controller: stateController
                                        ..text = data.state,
                                      decoration: InputDecoration(
                                        labelText: "State",
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    TextField(
                                      controller: lgaController
                                        ..text = data.lganame,
                                      decoration: InputDecoration(
                                        labelText: "LGA",
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    TextField(
                                      controller: addressController
                                        ..text = data.address,
                                      decoration: InputDecoration(
                                        labelText: "Address",
                                      ),
                                    ),
                                    const SizedBox(height: 20.0),
                                    MaterialButton(
                                      child: Text("Continue"),
                                      color: Colors.lightGreen,
                                      onPressed: () =>
                                          _navigateToDetail(context, data),
                                      textColor: Colors.white,
                                      padding: const EdgeInsets.all(16.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ))
                      .toList(),
                );
              },
            )));
  }

  _navigateToDetail(BuildContext context, Farmerdata models) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Kin(models)),
    );
  }

  captureWithCamera() async {
    // ignore: deprecated_member_use
    File imageFile = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 600.0, maxWidth: 970.0);
    setState(() {
      file = imageFile;
    });
  }

  Future<String> uploadItemImage(File mfile) async {
    final StorageReference storageReference =
        FirebaseStorage.instance.ref().child("farmers");
    StorageUploadTask storageUploadTask =
        storageReference.child('product_$productId.jpg').putFile(mfile);

    StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;

    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
