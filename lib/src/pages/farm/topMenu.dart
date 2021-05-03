import 'package:farmsys/src/src/providers/employee_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GopayMenu extends StatefulWidget {
  const GopayMenu({
    Key key,
  }) : super(key: key);

  @override
  _GopayMenuState createState() => _GopayMenuState();
}

class _GopayMenuState extends State<GopayMenu> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18),
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 8),
              Text(
                "Online farm mapping app",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 13),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 11),
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/indomaret.jpeg"),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Welcome to Farmsys",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontSize: 12),
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          "An innovative way of getting farmer to map out lands",
                          style: TextStyle(fontSize: 11, height: 1.5),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: InkWell(
              onTap: () => _loadfromapi(context),
              child: Container(
                width: 110,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.lightGreen[500]),
                child: Text(
                  "Download Data ",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _loadfromapi(BuildContext context) async {
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

    var apiProvider = EmployeeApiProvider();
    await apiProvider.getAllFarmers();
    // wait for 2 seconds to simulate loading of data
    await Future.delayed(const Duration(seconds: 2));
    displayToastMessage("Data has been gotten", context);
    Navigator.pop(context);
    Navigator.pushNamed(context, '/filterOnline');
  }

  displayToastMessage(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }
}
