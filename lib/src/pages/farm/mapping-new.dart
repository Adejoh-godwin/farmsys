import 'dart:math';
import 'package:farmsys/src/pages/farm/homepage.dart';
import 'package:farmsys/src/src/models/employee_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../src/providers/db_provider.dart';

class Mapping extends StatefulWidget {
  static const routeName = '/Mapping';
  final Farmerdata models;

  const Mapping({Key key, this.models}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreateTodoState(models);
}

class _CreateTodoState extends State<Mapping> {
  Farmerdata models;
  int id;
  String name;
  String bvn;
  String location;
  _CreateTodoState(this.models);

  // final Geolocator geo = Geolocator().distanceBetween(startLatitude, startLongitude, endLatitude, endLongitude)

  Position _currentPosition;

  dynamic distance = 0;

  dynamic lat = 0;
  dynamic flat = 0;
  dynamic flong = 0;
  dynamic long = 0;
  dynamic lat2 = 0;
  dynamic long2 = 0;
  dynamic lat3 = 0;
  dynamic long3 = 0;
  dynamic lat4 = 0;
  dynamic long4 = 0;
  dynamic lat5 = 0;
  dynamic long5 = 0;
  dynamic lat6 = 0;
  dynamic long6 = 0;
  dynamic lat7 = 0;
  dynamic long7 = 0;
  dynamic lat8 = 0;
  dynamic long8 = 0;
  dynamic lat9 = 0;
  dynamic long9 = 0;
  dynamic testD = 0;

  // var testDi =
  //     Geolocator.distanceBetween(9.1306336, 7.3701129, 9.121333, 7.3843781);
  _getCurrentLocation() {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      //Calculating the distance between two points without Geolocator plugin

      if (lat == 0) {
        setState(() {
          lat = _currentPosition.latitude;
          long = _currentPosition.longitude;
        });
      } else if (lat2 == 0) {
        setState(() {
          lat2 = _currentPosition.latitude;
          long2 = _currentPosition.longitude;

          distance = _coordinateDistance(lat, long, lat2, long2) * 100;
          testD = Geolocator.distanceBetween(lat, long, lat2, long2);
        });
      } else if (lat3 == 0) {
        setState(() {
          lat3 = _currentPosition.latitude;
          long3 = _currentPosition.longitude;
          flat = _currentPosition.latitude;
          flong = _currentPosition.longitude;
          distance = _coordinateDistance(lat, long, lat3, long3) * 100;
          testD = Geolocator.distanceBetween(lat, long, lat3, long3);
        });
      } else if (lat4 == 0) {
        setState(() {
          lat4 = _currentPosition.latitude;
          long4 = _currentPosition.longitude;
          flat = _currentPosition.latitude;
          flong = _currentPosition.longitude;
          distance = _coordinateDistance(lat, long, lat4, long4) * 100;
          testD = Geolocator.distanceBetween(lat, long, lat4, long4);
        });
      } else if (lat5 == 0) {
        setState(() {
          lat5 = _currentPosition.latitude;
          long5 = _currentPosition.longitude;

          flat = _currentPosition.latitude;
          flong = _currentPosition.longitude;

          distance = _coordinateDistance(lat, long, lat5, long5) * 100;
          testD = Geolocator.distanceBetween(lat, long, lat5, long5);
        });
      } else if (lat6 == 0) {
        setState(() {
          lat6 = _currentPosition.latitude;
          long6 = _currentPosition.longitude;

          flat = _currentPosition.latitude;
          flong = _currentPosition.longitude;
          Geolocator.distanceBetween(lat, long, lat6, long6);
          distance = _coordinateDistance(lat, long, lat6, long6) * 100;
          testD = Geolocator.distanceBetween(lat, long, lat6, long6);
        });
      } else if (lat7 == 0) {
        setState(() {
          lat7 = _currentPosition.latitude;
          long7 = _currentPosition.longitude;

          flat = _currentPosition.latitude;
          flong = _currentPosition.longitude;
          distance = _coordinateDistance(lat, long, lat7, long7) * 100;
          testD = Geolocator.distanceBetween(lat, long, lat7, long7);
        });
      } else if (lat8 == 0) {
        setState(() {
          lat8 = _currentPosition.latitude;
          long8 = _currentPosition.longitude;

          flat = _currentPosition.latitude;
          flong = _currentPosition.longitude;
          distance = _coordinateDistance(lat, long, lat8, long8) * 100;
          testD = Geolocator.distanceBetween(lat, long, lat8, long8);
        });
      } else if (lat9 == 0) {
        setState(() {
          lat9 = _currentPosition.latitude;
          long9 = _currentPosition.longitude;

          flat = _currentPosition.latitude;
          flong = _currentPosition.longitude;
          distance = _coordinateDistance(lat, long, lat9, long9) * 100;
          testD = Geolocator.distanceBetween(lat, long, lat9, long9);
        });
      }
    }).catchError((e) {
      print(e);
    });
  }

  dynamic _coordinateDistance(lat1, lon1, lat2, lon2) {
    var ans;
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    ans = (12742 * asin(sqrt(a)) / 100);
    return ans * ans;
  }

  @override
  void initState() {
    super.initState();
    if (models != null) {
      id = models.id;
      name = models.applicantfirstname + " " + models.applicantlastname;
      bvn = models.applicantbvn.toString();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Mapping details'),
        ),
        body: FutureBuilder<List<Farmerdata>>(
            future: DBProvider.db.getAllFarmersWithId(models),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());

              return ListView(
                padding: const EdgeInsets.all(16.0),
                children: snapshot.data
                    .map((data) => Column(
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
                                  ListTile(
                                    leading: Text(
                                        data.applicantlastname +
                                            " " +
                                            data.applicantfirstname,
                                        style: TextStyle(
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                    title: Text(models.applicantbvn.toString()),
                                    onTap: () {},
                                  ),
                                  _buildDivider(),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Text(
                              "Mapping Information",
                              style: TextStyle(
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
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
                                        children: [
                                          Text(
                                              "Distance: ${distance.toStringAsFixed(3)} ",
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
                                      child: Text("First Marking: $lat | $long",
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
                                      child: Text(
                                          "Second Marking: $lat2 | $long2",
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
                                      child: Text(
                                          "Third Marking: $lat3 | $long3",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              height: 2.0,
                                              color: Colors.black)),
                                    ),
                                  ),
                                  _buildDivider(),
                                  Visibility(
                                    visible: lat4 < 1 ? false : true,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(25, 3, 0, 8),
                                        child: Text(
                                            "Fouth Marking: $lat4 | $long4",
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                height: 2.0,
                                                color: Colors.black)),
                                      ),
                                    ),
                                  ),
                                  _buildDivider(),
                                  Visibility(
                                    visible: lat5 < 1 ? false : true,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(25, 3, 0, 8),
                                        child: Text(
                                            "Fifth Marking: $lat5 | $long5",
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                height: 2.0,
                                                color: Colors.black)),
                                      ),
                                    ),
                                  ),
                                  _buildDivider(),
                                  Visibility(
                                    visible: lat6 > 0 ? true : false,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(25, 3, 0, 8),
                                        child: Text(
                                            "Sixth Marking: $lat6 | $long6",
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                height: 2.0,
                                                color: Colors.black)),
                                      ),
                                    ),
                                  ),
                                  _buildDivider(),
                                  Visibility(
                                    visible: lat7 > 0 ? true : false,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(25, 3, 0, 8),
                                        child: Text(
                                            "Seventh Marking: $lat7 | $long7",
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                height: 2.0,
                                                color: Colors.black)),
                                      ),
                                    ),
                                  ),
                                  _buildDivider(),
                                  Visibility(
                                    visible: lat8 > 0 ? true : false,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(25, 3, 0, 8),
                                        child: Text(
                                            "Eighth Marking: $lat8 | $long8",
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                height: 2.0,
                                                color: Colors.black)),
                                      ),
                                    ),
                                  ),
                                  _buildDivider(),
                                  Visibility(
                                    visible: lat9 > 0 ? true : false,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(25, 3, 0, 8),
                                        child: Text(
                                            "Ninth Marking: $lat9 | $long9",
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                height: 2.0,
                                                color: Colors.black)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              elevation: 3,
                              child: ClipPath(
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              color: Colors.green, width: 15))),
                                  child: ListTile(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(40, 0, 0, 0),
                                    leading: Icon(Icons.location_pin),
                                    title: Text("Add Marker"),
                                    onTap: () {
                                      _getCurrentLocation();
                                    },
                                  ),
                                ),
                                clipper: ShapeBorderClipper(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              ),
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RaisedButton(
                                  color: Colors.redAccent,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    _clear();
                                  },
                                  padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                                  child: Text('Clear'),
                                ),
                                SizedBox(
                                  width: 18,
                                ),
                                RaisedButton(
                                  color: Colors.greenAccent,
                                  textColor: Colors.white,
                                  onPressed: () async {
                                    print(lat);
                                    _saveTodo(
                                      data,
                                      lat,
                                      long,
                                      flat,
                                      flong,
                                      distance,
                                    );
                                  },
                                  padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                                  child: Text('Save'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 60.0),
                          ],
                        ))
                    .toList(),
              );
            }));
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

  _saveTodo(
    Farmerdata data,
    dynamic latitude1,
    dynamic longitude1,
    dynamic flat,
    dynamic flong,
    dynamic hectaredistance,
  ) async {
    await DBProvider.db.updateTodo2(Farmerdata(
      id: models.id,
      applicantbvn: data.applicantbvn,
      applicantfirstname: data.applicantfirstname,
      applicantlastname: data.applicantlastname,
      applicantmiddlename: data.applicantmiddlename,
      applicantgender: data.applicantgender,
      occupation: data.occupation,
      spousebvn: data.spousebvn,
      maritalstatus: data.maritalstatus,
      address: data.address,
      city: data.city,
      lgacode: data.lgacode,
      lganame: data.lganame,
      statecode: data.statecode,
      state: data.state,
      nokbvn: data.nokbvn,
      nokrelationship: data.nokrelationship,
      fnpk: data.fnpk,
      forganic: data.forganic,
      micronutrient: data.micronutrient,
      knapsack: data.knapsack,
      insecticide: data.insecticide,
      furea: data.furea,
      hlagon: data.hlagon,
      hnsco: data.hnsco,
      latitude: latitude1.toString(),
      longitude: longitude1.toString(),
      flat: flat.toString(),
      flong: flong.toString(),
      hectaredistance: hectaredistance.toString(),
    ));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Submitted Successfully"),
          actions: <Widget>[
            FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
            ),
          ],
        );
      },
    );
  }

  void _clear() {
    setState(() {
      distance = 0;
      lat = 0;
      long = 0;
      lat2 = 0;
      long2 = 0;
      lat3 = 0;
      long3 = 0;
      lat4 = 0;
      long5 = 0;
      lat5 = 0;
      long4 = 0;
      lat6 = 0;
      long6 = 0;
      lat7 = 0;
      long8 = 0;
    });
  }
}
