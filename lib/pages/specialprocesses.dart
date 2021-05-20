import 'package:accountin/pages/total.dart';
import 'package:accountin/pages/theprocess.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:accountin/databasehelper/DataBaseHelper.dart';
import 'package:accountin/appclasses/process.dart';

class SpecialProcesses extends StatefulWidget {
  final String clientName, secondPerson;
  const SpecialProcesses(this.clientName, this.secondPerson);
  @override
  _SpecialProcessesState createState() => _SpecialProcessesState();
}

class _SpecialProcessesState extends State<SpecialProcesses> {
  String x;
  List<Process> items = new List();
  DataBaseHelper db = new DataBaseHelper();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db.viewTheProcessOfPerson(widget.clientName, widget.secondPerson).then((covariant){
      setState(() {
        covariant.forEach((covariant){
          items.add(Process.fromMap(covariant));
        });
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.clientName + ' _ ' + widget.secondPerson),
          centerTitle: true,
          backgroundColor: Colors.grey[800],
        ),
        body: Center(
          child:
          ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.all(15.0),
              itemBuilder: (context, position) {
                return Column(
                  children: <Widget>[
                    Divider(height: 5.0,),
                    Row(
                      children: <Widget>[
                        new Expanded(
                            child: ListTile(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => TheProcess(items[position].processid),),);
                              },
                              title: Text('${items[position].fromOne}',
                                style: TextStyle(
                                    fontSize: 22.0, color: Colors.blueGrey
                                ),
                              ),
                              subtitle: Text('${items[position]
                                  .toAnother} - ${items[position]
                                  .date} - ${items[position].money}',
                                style: TextStyle(
                                  fontSize: 16.0, fontStyle: FontStyle.italic,
                                ),
                              ),
                            )
                        ),
                      ],
                    ),
                  ],
                );
              }
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.zoom_out_map),
          backgroundColor: Colors.grey[800],
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Total(widget.clientName, widget.secondPerson),),);
          },
        ),
      );
  }
}
