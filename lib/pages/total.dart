import 'package:accountin/databasehelper/DataBaseHelper.dart';
import 'package:flutter/material.dart';

class Total extends StatefulWidget {
  final String clientName;
  final String secondPerson;
  const Total(this.clientName, this.secondPerson);
  @override
  _TotalState createState() => _TotalState();
}

class _TotalState extends State<Total> {
  DataBaseHelper db = DataBaseHelper();
 Future<int> addition() async{
    var addVar = await db.theTotal(widget.clientName, widget.secondPerson);
    return addVar;
  }
  Future<int> additionFM() async{
    var addVar = await db.theTotalFT(widget.clientName, widget.secondPerson);
    return addVar;
  }
  @override
  Widget build(BuildContext context) {
    var futureBuilder = FutureBuilder(
      future: addition(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text("0");
          case ConnectionState.waiting:
            return Text('loading...');
          default:
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            else
              return getNum(context, snapshot);
        }
      },
    );
    var futureBuilder1 = FutureBuilder(
      future: additionFM(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text("0");
          case ConnectionState.waiting:
            return Text('loading...');
          default:
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            else
              return getNum1(context, snapshot);
        }
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("account of " + widget.clientName),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
      ),
      body: Container(
        child: DataTable(
          columns: [
            DataColumn(label: Text("From")),
            DataColumn(label: Text("To")),
            DataColumn(label: Text("Total")),],
          rows: [
            DataRow(cells: [
              DataCell(Text(widget.clientName)),
              DataCell(Text(widget.secondPerson)),
              DataCell(futureBuilder),
            ]),
            DataRow(cells: [
              DataCell(Text(widget.secondPerson)),
              DataCell(Text(widget.clientName)),
              DataCell(futureBuilder1),
            ]),
          ],
        ),
      ),
    );
  }
  Widget getNum(BuildContext context, AsyncSnapshot snapshot){
   int addNum = snapshot.data;
   return Text("$addNum");
  }
  Widget getNum1(BuildContext context, AsyncSnapshot snapshot){
    int subNum = snapshot.data;
    return Text("$subNum");
  }
}
