import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

List<RandomExpenses> randomExpensesFromJson(String str) =>
    List<RandomExpenses>.from(
        json.decode(str).map((x) => RandomExpenses.fromJson(x)));

String randomExpensesToJson(List<RandomExpenses> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RandomExpenses {
  String name;
  int amount;

  RandomExpenses({
    this.name,
    this.amount,
  });

  factory RandomExpenses.fromJson(Map<String, dynamic> json) => RandomExpenses(
        name: json["name"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "amount": amount,
      };
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<RandomExpenses> randomExpensesList = [
    RandomExpenses(name: "Rent", amount: 250),
    RandomExpenses(name: "Insurance", amount: 105)
  ];

  void saveData(String key, List<RandomExpenses> value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, randomExpensesToJson(value));
  }

  Future<List<RandomExpenses>> getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String keyString = prefs.getString(key);
    return Future.value(randomExpensesFromJson(keyString));
  }

  void _incrementCounter() async {
    // ignore: await_only_futures
    await saveData("key", randomExpensesList);
    List<RandomExpenses> list = await getData("key");

    print('${list[0].name} ${list[0].amount}');
    print('${list[1].name} ${list[1].amount}');

    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
