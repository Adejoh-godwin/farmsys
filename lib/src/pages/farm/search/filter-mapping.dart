import 'dart:async';
import 'package:farmsys/src/pages/farm/search/searchwidget.dart';
import 'package:farmsys/src/pages/qrcode/scanpage.dart';
import 'package:farmsys/src/src/models/employee_model.dart';
import 'package:farmsys/src/src/providers/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:farmsys/src/pages/farm/mapping-new.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class FilterMapping extends StatefulWidget {
  @override
  FilterMappingState createState() => FilterMappingState();
}

class FilterMappingState extends State<FilterMapping> {
  List<Farmerdata> books = [];
  String query = '';
  Timer debouncer;

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  void dispose() {
    debouncer.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final books = await DBProvider.db.getAllFarmersSearch(query);

    setState(() => this.books = books);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Farmers'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.greenAccent,
            child: Icon(
              FontAwesome.qrcode,
              //color: Colors.greenAccent,
            ),
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ScanPage()))),
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
        hintText: 'BVN or Farmer Name',
        onChanged: searchBook,
      );

  Future searchBook(String query) async => debounce(() async {
        final books = await DBProvider.db.getAllFarmersSearch(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.books = books;
        });
      });
  Widget buildBook(Farmerdata book) => ListTile(
        onTap: () => _navigateToDetail(context, book),
        // leading: Image.network(
        //   book.image,
        //   fit: BoxFit.cover,
        //   width: 50,
        //   height: 50,
        // ),
        title: Text(book.applicantfirstname + " " + book.applicantlastname),
        subtitle: Text(book.applicantbvn.toString()),
      );
  _navigateToDetail(BuildContext context, Farmerdata models) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Mapping(models: models)),
    );
  }
}
