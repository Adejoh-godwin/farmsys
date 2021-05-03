import 'package:farmsys/src/src/models/employee_model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class Kin extends StatefulWidget {
  final Farmerdata models;
  Kin(this.models);
  @override
  State<StatefulWidget> createState() {
    return SecondScreen(this.models);
  }
}

class Studentdata {
  int id;

  Studentdata({this.id});

  factory Studentdata.fromJson(Map<String, dynamic> json) {
    return Studentdata(id: json['id']);
  }
}

class SecondScreen extends State<Kin> {
  Farmerdata models;
  File file;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final dobcontroller = TextEditingController();
  final relationshipcontroller = TextEditingController();
  final addresscontroller = TextEditingController();

  String productId = DateTime.now().millisecondsSinceEpoch.toString();

  bool uploading = false;

  SecondScreen(this.models);

  // API URL
  var url = 'https://hdtechng.com/fetch.php';

  Future<List<Studentdata>> fetchStudent() async {
    var data = {'id': int.parse(models.id)};

    var response = await http.post(url, body: json.encode(data));

    if (response.statusCode == 200) {
      print(response.statusCode);

      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<Studentdata> studentList = items.map<Studentdata>((json) {
        return Studentdata.fromJson(json);
      }).toList();

      return studentList;
    } else {
      throw Exception('Failed to load data from Server.');
    }
  }

  // Boolean variable for CircularProgressIndicator.
  bool visible = false;

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
            body: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 10.0),
                      TextField(
                        controller: phoneController
                          ..text = models.applicantbvn.toString(),
                        decoration: InputDecoration(
                          labelText: "Kin BVN",
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      TextField(
                        controller: relationshipcontroller
                          ..text = models.nokrelationship,
                        decoration: InputDecoration(
                          labelText: "Kin Relationship",
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      MaterialButton(
                        child: Text("Continue"),
                        color: Colors.lightGreen,
                        onPressed: () => Navigator.pushNamed(context, 'home'),
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
