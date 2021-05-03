import 'dart:convert';
import 'package:farmsys/model/newModel.dart';
import 'package:farmsys/src/pages/farm/search/bookmodel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() => runApp(SharedPrefsJsonDemo());

class SharedPrefsJsonDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coflutter - SharedPrefs with Json',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Coflutter - SharedPrefs with Json'),
          backgroundColor: const Color(0xffae00f0),
        ),
        body: DemoScreen(),
      ),
    );
  }
}

class DemoScreen extends StatefulWidget {
  @override
  _DemoScreenState createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  List<Book> books = [];
  @override
  void initState() {
    super.initState();

    saveUserInfo();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: getUserInfo,
        child: Text('Show user info'),
      ),
    );
  }

  Future<List<Book>> getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String userStr = prefs.getString('user2');
    print(userStr);
    final items = json.decode(userStr).cast<Map<String, dynamic>>();

    List<Book> studentList = items.map<Book>((json) {
      return Book.fromJson(json);
    }).toList();

    return studentList;
  }

  Future<List<Book>> getBooks() async {
    final url = Uri.parse('https://hdtechng.com/select.php');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List books = json.decode(response.body);
      // print(books);
      List<Book> studentList = books.map<Book>((json) {
        return Book.fromJson(json);
      }).toList();

      return studentList;
    } else {
      throw Exception();
    }
  }

  Future init() async {
    final books = await getBooks();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result = await prefs.setString('user2', jsonEncode(books));
    print(result);

    setState(() => this.books = books);
  }

  Future<void> saveUserInfo() async {
    final Studentdata user = Studentdata.fromJson({
      'info': {
        'id': '1',
        'name': 'Coflutter',
        'avatar': 'https://example.com/coflutter.jpg'
      },
      'token': 'xxx'
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result = await prefs.setString('user', jsonEncode(user));
    print(result);
  }
}

class Info {
  String id;
  String name;
  String avatar;

  Info({this.id, this.name, this.avatar});

  Info.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    return data;
  }

  @override
  String toString() {
    return '"info" : { "id": $id, "name": $name, "avatar": $avatar}';
  }
}

class User {
  Info info;
  String token;

  User({this.info, this.token});

  User.fromJson(Map<String, dynamic> json) {
    info = json['info'] != null ? Info.fromJson(json['info']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.info != null) {
      data['info'] = this.info.toJson();
    }
    data['token'] = this.token;
    return data;
  }

  @override
  String toString() {
    return '"user" : {${info.toString()}, "token": $token}';
  }
}
