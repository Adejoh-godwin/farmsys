import 'package:flutter/material.dart';

import 'package:farmsys/src/utils/oval-right-clipper.dart';

class MyDrawer extends StatelessWidget {
  static final String path = "lib/src/pages/navigation/drawer2.dart";
  final Color primary = Colors.white;
  final Color active = Colors.grey.shade800;
  final Color divider = Colors.grey.shade600;

  @override
  Widget build(BuildContext context) {
    return _buildDrawer(context);
  }

  _buildDrawer(context) {
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 40),
          decoration: BoxDecoration(
              color: primary, boxShadow: [BoxShadow(color: Colors.black45)]),
          width: 300,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.power_settings_new,
                        color: active,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Aejoh Godwin",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "admin1@gmail.com",
                    style: TextStyle(color: active, fontSize: 16.0),
                  ),
                  SizedBox(height: 30.0),
                  _buildRow(context, '/home', Icons.home, "Home"),
                  _buildDivider(),
                  _buildRow(context, '/filterOnline',
                      Icons.remove_red_eye_sharp, "View Farmers"),
                  _buildDivider(),
                  _buildRow(context, '/map', Icons.map_rounded, "Mapping"),
                  _buildDivider(),
                  _buildRow(context, '/fliterdistribution', Icons.edit,
                      "Input Distribution"),
                  _buildDivider(),
                  // _buildRow(context, '/contact', Icons.email, "Contact us"),
                  // _buildDivider(),
                  // _buildRow(context, '/about', Icons.email, "About us"),
                  // _buildDivider(),
                  // _buildRow(context, '/help', Icons.info_outline, "Help"),
                  // _buildDivider(),
                  _buildRow(
                      context, '/login', Icons.power_settings_new, "Logout"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Divider _buildDivider() {
    return Divider(
      color: divider,
    );
  }

  Widget _buildRow(context, route, IconData icon, String title,
      {bool showBadge = false}) {
    final TextStyle tStyle = TextStyle(color: active, fontSize: 16.0);
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(children: [
          Icon(
            icon,
            color: active,
          ),
          SizedBox(width: 10.0),
          Text(
            title,
            style: tStyle,
          ),
          Spacer(),
          if (showBadge)
            Material(
              color: Colors.deepOrange,
              elevation: 5.0,
              shadowColor: Colors.red,
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                width: 25,
                height: 25,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  "10+",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
        ]),
      ),
    );
  }
}
