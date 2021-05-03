import 'package:farmsys/helper/OnlineDbHelper.dart';
import 'package:farmsys/model/Onlinemodel.dart';
import 'package:flutter/material.dart';

class OnlinerView extends StatefulWidget {
  @override
  _OnlinerViewState createState() => _OnlinerViewState();
}

class _OnlinerViewState extends State<OnlinerView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Farmers'),
      ),
      body: FutureBuilder<List<Onlinemodel>>(
        future: DatabaseHelper.instance.retrieveTodos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(snapshot.data[index].name),
                  leading: Text(snapshot.data[index].id.toString()),
                  subtitle: Text(snapshot.data[index].phone),
                  onTap: () => _navigateToDetail(context, snapshot.data[index]),
                  trailing: IconButton(
                      alignment: Alignment.center,
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        _deleteTodo(snapshot.data[index]);
                        setState(() {});
                      }),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("An error Occured!");
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightGreen,
          child: Icon(Icons.add_circle),
          onPressed: () async {
            Navigator.pushNamed(context, '/viewDetails');
          }),
    );
  }
}

_deleteTodo(Onlinemodel inputs) {
  DatabaseHelper.instance.deleteTodo(inputs.id);
}

_navigateToDetail(BuildContext context, Onlinemodel inputs) async {
  // Navigator.push(
  //   context,
  //   MaterialPageRoute(builder: (context) => ViewDetails(models: inputs)),
  // );
}
