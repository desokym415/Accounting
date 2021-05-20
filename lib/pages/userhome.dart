import 'package:flutter/material.dart';
import 'dart:core';
import 'package:accountin/databasehelper/DataBaseHelper.dart';
import 'package:accountin/pages/specialpersons.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  DataBaseHelper db = DataBaseHelper();
  Future<List<String>> printInProcess() async {
    var result = await db.allNames();
    List<String> allNames = List();
    for (var x in result) {
      x.forEach((k, v) => allNames.add(v));
    }
    var distinctAllNames = allNames.toSet().toList();
    return distinctAllNames;
  }
  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('You are going to exit the application !'),
            actions: <Widget>[
              FlatButton(
                child: Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text('YES'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    var futureBuilder = FutureBuilder(
      future: printInProcess(),
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
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: Text('Home'),
              centerTitle: true,
              backgroundColor: Colors.grey[800],
            ),
            body: futureBuilder,
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: Colors.grey[800],
              onPressed: () {
                Navigator.pushNamed(context, '/addprocess');
                //Navigator.push(context, MaterialPageRoute(builder: (context) => AddProcess(),),);
              },
            ),
          )),
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
              title: Text(values[index]),
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context) => SpecialPersons(values[index]),),);
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
