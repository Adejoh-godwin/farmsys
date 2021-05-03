import 'package:farmsys/src/pages/farm/homepage.dart';
import 'package:farmsys/src/src/models/employee_model.dart';
import 'package:farmsys/src/src/providers/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class InputDistribution extends StatefulWidget {
  final Farmerdata models;

  const InputDistribution({Key key, this.models}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreateTodoState(models);
}

class _CreateTodoState extends State<InputDistribution> {
  Farmerdata models;
  bool loading = false;
  final fnpkController = TextEditingController();
  final fureaController = TextEditingController();
  final forganicController = TextEditingController();
  final microController = TextEditingController();
  final knapsackController = TextEditingController();
  final insecticideController = TextEditingController();
  final hlagonController = TextEditingController();
  final hnscoController = TextEditingController();
  String name;
  String phone;
  _CreateTodoState(this.models);

  @override
  void initState() {
    super.initState();
    if (models != null) {
      name = models.applicantfirstname + " " + models.applicantlastname;
      phone = models.applicantbvn;
    }
    print(models);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Subscription'),
      ),
      body: FutureBuilder<List<Farmerdata>>(
          future: DBProvider.db.getAllFarmersWithId(models),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());

            return ListView(
                padding: const EdgeInsets.all(16.0),
                children: snapshot.data
                    .map(
                      (data) => Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TextField(
                                  controller: fnpkController,
                                  decoration: InputDecoration(
                                    labelText: "Fertilzer (NPK)",
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                TextField(
                                  controller: fureaController,
                                  decoration: InputDecoration(
                                    labelText: "Fertlzer (FUREA)",
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                TextField(
                                  controller: forganicController,
                                  decoration: InputDecoration(
                                    labelText: "Fertilzer (organic)",
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                TextField(
                                  controller: microController,
                                  decoration: InputDecoration(
                                    labelText: "Micro Nutrients",
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                TextField(
                                  controller: knapsackController,
                                  decoration: InputDecoration(
                                    labelText: "Knapsack Sprayer",
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                TextField(
                                  controller: insecticideController,
                                  decoration: InputDecoration(
                                    labelText: "Insecticide",
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                TextField(
                                  controller: hlagonController,
                                  decoration: InputDecoration(
                                    labelText: "Herbicide Lagon",
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                TextField(
                                  controller: hnscoController,
                                  decoration: InputDecoration(
                                    labelText: "Herbicide Niscofulron",
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                MaterialButton(
                                  child: Text("Continue"),
                                  color: Colors.lightGreen,
                                  onPressed: () async {
                                    _saveTodo(
                                      data,
                                      fnpkController.text,
                                      fureaController.text,
                                      forganicController.text,
                                      microController.text,
                                      knapsackController.text,
                                      insecticideController.text,
                                      hlagonController.text,
                                      hnscoController.text,
                                    );
                                  },
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
                      ),
                    )
                    .toList());
          }),
      // floatingActionButton: FloatingActionButton(
      //     child: Icon(Icons.check),
      //     onPressed: () async {
      //       _saveTodo(phoneController.text, nameController.text);
      //       setState(() {});
      //     }),
    );
  }

  _saveTodo(
    Farmerdata data,
    String fnpk,
    String furea,
    String forganic,
    String micronutrient,
    String knapsack,
    String insecticide,
    String hlagon,
    String hnsco,
  ) async {
    setState(() {
      loading = true;
    });
    if (loading == true) {
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
    }

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
        latitude: data.latitude.toString(),
        longitude: data.longitude.toString(),
        flat: data.flat.toString(),
        flong: data.flong.toString(),
        hectaredistance: data.hectaredistance.toString(),
        fnpk: fnpk,
        furea: furea,
        forganic: forganic,
        micronutrient: micronutrient,
        knapsack: knapsack,
        insecticide: insecticide,
        hlagon: hlagon,
        hnsco: hnsco));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text('Added Successfully'),
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
}
