import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsys/src/listViewfromJson.dart';
import 'package:farmsys/src/pages/farm/homepage.dart';
import 'package:farmsys/src/pages/farm/knowYourFarmer.dart';
import 'package:farmsys/src/pages/farm/online.dart';
import 'package:farmsys/src/pages/farm/search/filter-distribution.dart';
import 'package:farmsys/src/pages/farm/search/filter-network.dart';
import 'package:farmsys/src/pages/farm/search/filter-sqlite.dart';
import 'package:farmsys/src/pages/farm/viewDetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/config.dart';
import 'src/pages/farm/login.dart';
import 'src/src/pages/offlinesqlite.dart';
import 'src/pages/farm/search/filter-mapping.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  EcommerceApp.auth = FirebaseAuth.instance;

  EcommerceApp.sharedPreferences = await SharedPreferences.getInstance();

  EcommerceApp.firestore = Firestore.instance;

  EcommerceApp.sharedPreferences = await SharedPreferences.getInstance();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final number = EcommerceApp.sharedPreferences.getString('userStatus');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: (number != null) ? '/home' : '/',
      //initialRoute: '/sqlite',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => AuthThreePage(),
        // '/input': (context) => ViewFarmersInput(),
        '/map': (context) => FilterMapping(),
        '/online': (context) => OnlinerView(),
        '/viewDetails': (context) => ViewDetails(),
        '/home': (context) => Home(),
        '/knowyourfarmer': (context) => KnowYourFarmer(),
        '/viewjson': (context) => HomePage(),
        '/filterOnline': (context) => FilterNetworkListPage(),
        '/offline': (context) => Offline(),
        '/fliterdistribution': (context) => FilterDistribution(),
        '/sqlite': (context) => SqliteSearch(),
      },
      title: 'FarmSys',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
    );
  }
}
