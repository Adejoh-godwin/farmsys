import 'dart:convert';
import 'package:farmsys/src/src/models/employee_model.dart';
import 'package:http/http.dart' as http;

class BooksApi {
  static Future<List<Farmerdata>> getBooks(String query) async {
    final url = Uri.parse('https://hdtechng.com/select.php');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List books = json.decode(response.body);

      return books.map((json) => Farmerdata.fromJson(json)).where((book) {
        final titleLower = book.applicantfirstname.toLowerCase();
        final authorLower = book.applicantlastname.toLowerCase();
        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower) ||
            authorLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
