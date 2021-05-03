import 'dart:convert';
import 'package:farmsys/helper/dbProvider.dart';
import 'package:farmsys/model/newModel.dart';
import 'package:http/http.dart' as http;

class EmployeeApiProvider {
  Future<List<Studentdata>> getAllEmployees() async {
    var url = "https://hdtechng.com/select.php";
    var response = await http.get(url);
    final items = json.decode(response.body).cast<Map<String, dynamic>>();

    List<Studentdata> studentList = items.map<Studentdata>((json) {
      DBProvider.db.createEmployee(Studentdata.fromJson(json));
      return Studentdata.fromJson(json);
    }).toList();
    return studentList;
  }
}
