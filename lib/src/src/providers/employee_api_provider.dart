import '../models/employee_model.dart';
import '../providers/db_provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EmployeeApiProvider {
  Future<List<Farmerdata>> getAllFarmers() async {
    var url = "https://hdtechng.com/select.php";
    var response = await http.get(url);
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    print(items);
    List<Farmerdata> studentList = items.map<Farmerdata>((json) {
      DBProvider.db.createEmployee(Farmerdata.fromJson(json));
      return Farmerdata.fromJson(json);
    }).toList();
    return studentList;
  }
}
