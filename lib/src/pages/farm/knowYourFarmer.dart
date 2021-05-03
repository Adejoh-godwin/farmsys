import 'package:farmsys/src/pages/farm/updateFarmers.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class KnowYourFarmer extends StatelessWidget {
  final TextStyle dropdownMenuItem =
      TextStyle(color: Colors.black, fontSize: 18);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.lightGreen,
            elevation: 0,
            title: Text('Farmers'),
            centerTitle: true,
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            )),
        body: Farmers(dropdownMenuItem: dropdownMenuItem),
      ),
    );
  }
}

class Farmers extends StatelessWidget {
  const Farmers({
    Key key,
    @required this.dropdownMenuItem,
  }) : super(key: key);

  final TextStyle dropdownMenuItem;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(top: 85),
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: MainListView()),
            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[],
                ),
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: TextField(
                        // controller: TextEditingController(text: locations[0]),
                        cursorColor: Theme.of(context).primaryColor,
                        style: dropdownMenuItem,
                        decoration: InputDecoration(
                            hintText: "Search Farmers",
                            hintStyle:
                                TextStyle(color: Colors.black38, fontSize: 16),
                            prefixIcon: Material(
                              elevation: 0.0,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              child: Icon(Icons.search),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 13)),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Studentdata {
  dynamic studentID;
  dynamic idnumber;
  dynamic studentName;
  dynamic studentPhoneNumber;
  dynamic state;
  dynamic lga;
  dynamic ward;
  dynamic boaacctno;
  dynamic cooperativesociety;
  dynamic farmlocation;
  dynamic image;

  Studentdata(
      {this.studentID,
      this.studentName,
      this.studentPhoneNumber,
      this.state,
      this.boaacctno,
      this.cooperativesociety,
      this.farmlocation,
      this.lga,
      this.idnumber,
      this.image,
      this.ward});

  factory Studentdata.fromJson(Map<String, dynamic> json) {
    return Studentdata(
        studentID: json['id'],
        studentName: json['name'],
        studentPhoneNumber: json['phone'],
        state: json['state'],
        boaacctno: json['boa_acct_no'].toString(),
        lga: json['lga'],
        idnumber: json['id_number'],
        ward: json['ward'],
        farmlocation: json['farm_location'],
        cooperativesociety: json['cooperative_society'],
        image: json['image']);
  }
}

class MainListView extends StatefulWidget {
  MainListViewState createState() => MainListViewState();
}

class MainListViewState extends State {
  final primary = Color(0xff696b9e);
  final secondary = Color(0xfff29a94);
  final String apiURL = 'https://hdtechng.com/select.php';

  Future<List<Studentdata>> fetchStudents() async {
    var response = await http.get(apiURL);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<Studentdata> studentList = items.map<Studentdata>((json) {
        return Studentdata.fromJson(json);
      }).toList();

      return studentList;
    } else {
      throw Exception('Failed to load data from Server.');
    }
  }

  navigateToNextActivity(BuildContext context, int dataHolder) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SecondScreenState(dataHolder.toString())));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Studentdata>>(
      future: fetchStudents(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

        return ListView(
          children: snapshot.data
              .map((data) => Column(
                    children: <Widget>[
                      Ink(
                        child: InkWell(
                          splashColor: Colors.orange,
                          onTap: () {
                            navigateToNextActivity(context, data.studentID);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white,
                            ),
                            width: double.infinity,
                            height: 110,
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                data.image == ''
                                    ? Container(
                                        width: 50,
                                        height: 50,
                                        margin: EdgeInsets.only(right: 15),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                              width: 3,
                                              color: Colors.lightGreenAccent),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "https://cdn.pixabay.com/photo/2017/03/16/21/18/logo-2150297_960_720.png"),
                                              fit: BoxFit.fill),
                                        ),
                                      )
                                    : Container(
                                        width: 50,
                                        height: 50,
                                        margin: EdgeInsets.only(right: 15),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                              width: 3,
                                              color: Colors.lightGreenAccent),
                                          image: DecorationImage(
                                              image: NetworkImage(data.image),
                                              fit: BoxFit.fill),
                                        ),
                                      ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        data.studentName,
                                        style: TextStyle(
                                            color: primary,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.phone,
                                            color: primary,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                              data.studentPhoneNumber
                                                  .toString(),
                                              style: TextStyle(
                                                  color: primary,
                                                  fontSize: 13,
                                                  letterSpacing: .3)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.location_on,
                                            color: primary,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(data.state.toString(),
                                              style: TextStyle(
                                                  color: primary,
                                                  fontSize: 13,
                                                  letterSpacing: .3)),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))
              .toList(),
        );
      },
    );
  }
}
