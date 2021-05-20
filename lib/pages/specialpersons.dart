import 'package:accountin/pages/addprocess.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:accountin/databasehelper/DataBaseHelper.dart';
import 'package:accountin/pages/specialprocesses.dart';
class SpecialPersons extends StatefulWidget {
  final String accountName;
  const SpecialPersons(this.accountName);
  @override
  _SpecialPersonsState createState() => _SpecialPersonsState();
}

class _SpecialPersonsState extends State<SpecialPersons> {
  DataBaseHelper db = DataBaseHelper();
  @override
  Widget build(BuildContext context) {
    var futureBuilder = FutureBuilder(
      future: db.viewSpecialPersons(widget.accountName),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return new Text('loading...');
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else
              return createListView(context, snapshot);
        }
      },
    );
    return Scaffold(
          appBar: AppBar(
            title: Text(widget.accountName + ' account'),
            centerTitle: true,
            backgroundColor: Colors.grey[800],
          ),
          body: futureBuilder,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.grey[800],
            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => AddProcess(),),);
            },
          ),
        );
  }
  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<String> values = snapshot.data;
    return ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            ListTile(
              title: Text(widget.accountName + " _ " + values[index]),
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context) => SpecialProcesses(widget.accountName, values[index]),),);
              },
            ),
            Divider(
              height: 2.0,
            ),
          ],
        );
      },
    );
  }
}
