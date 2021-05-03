import 'package:farmsys/src/pages/farm/search/bookdata.dart';
import 'package:farmsys/src/pages/farm/search/searchwidget.dart';
import 'package:farmsys/src/src/models/employee_model.dart';
import 'package:flutter/material.dart';

class FilterLocalListPage extends StatefulWidget {
  @override
  FilterLocalListPageState createState() => FilterLocalListPageState();
}

class FilterLocalListPageState extends State<FilterLocalListPage> {
  List<Farmerdata> books;
  String query = '';

  @override
  void initState() {
    super.initState();

    books = allBooks;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('filter'),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            buildSearch(),
            Expanded(
              child: ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];

                  return buildBook(book);
                },
              ),
            ),
          ],
        ),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Title or Author Name',
        onChanged: searchBook,
      );

  Widget buildBook(Farmerdata book) => ListTile(
        title: Text(book.applicantfirstname),
        subtitle: Text(book.applicantbvn),
      );

  void searchBook(String query) {
    final books = allBooks.where((book) {
      final titleLower = book.applicantfirstname.toLowerCase();
      final authorLower = book.applicantbvn.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          authorLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.books = books;
    });
  }
}
