import 'package:farmsys/src/pages/farm/viewDetails.dart';
import 'package:farmsys/src/src/models/books.dart';
import 'package:farmsys/src/src/models/employee_model.dart';

import '../providers/db_provider.dart';
import '../providers/employee_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:farmsys/src/pages/farm/search/bookmodel.dart';
import 'package:farmsys/src/pages/farm/search/searchwidget.dart';

class Offline extends StatefulWidget {
  const Offline({Key key}) : super(key: key);

  @override
  _OfflineState createState() => _OfflineState();
}

class _OfflineState extends State<Offline> {
  var isLoading = false;
  List<Book> books;
  String query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Farmers'),
        centerTitle: true,
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: Icon(Icons.settings_input_antenna),
              onPressed: () async {
                await _loadFromApi();
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                await _deleteData();
              },
            ),
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _buildEmployeeListView(),
    );
  }

  _loadFromApi() async {
    setState(() {
      isLoading = true;
    });

    var apiProvider = EmployeeApiProvider();
    await apiProvider.getAllFarmers();

    // wait for 2 seconds to simulate loading of data
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }

  _deleteData() async {
    setState(() {
      isLoading = true;
    });

    await DBProvider.db.deleteAllFarmers();

    // wait for 1 second to simulate loading of data
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isLoading = false;
    });

    print('All Farmers deleted');
  }

  _buildEmployeeListView() {
    return FutureBuilder(
      future: DBProvider.db.getAllFarmers2(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Colors.black12,
            ),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () => _navigateToDetail(context, snapshot.data[index]),
                leading: Text(
                  "${index + 1}",
                  style: TextStyle(fontSize: 20.0),
                ),
                title: Text(
                    "Names: ${snapshot.data[index].applicantfirstname} ${snapshot.data[index].applicantlastname} "),
                subtitle: Text('BVN: ${snapshot.data[index].applicantbvn}'),
              );
            },
          );
        }
      },
    );
  }

  _navigateToDetail(BuildContext context, Farmerdata inputs) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ViewDetails(models: inputs)),
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Title or Author Name',
        onChanged: searchBook,
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
