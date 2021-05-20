import 'package:accountin/databasehelper/DataBaseHelper.dart';
import 'package:accountin/pages/editprocess.dart';
import 'package:flutter/material.dart';

class TheProcess extends StatefulWidget {
  final int idOfProcess;
  const TheProcess(this.idOfProcess);
  @override
  _TheProcessState createState() => _TheProcessState();
}

class _TheProcessState extends State<TheProcess> {
  final _formKey = GlobalKey<FormState>();
  DataBaseHelper db = DataBaseHelper();
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("No"),
      onPressed:  () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes"),
      onPressed:  () {
        db.deleteProcess(widget.idOfProcess);
        Navigator.of(context, rootNavigator: true).pop('dialog');
        Navigator.of(context).pop(true);
        Navigator.of(context).pop(true);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Warning",style: TextStyle(
        color: Colors.red,
      ),),
      content: Text("Are you sure you want to delete the process !"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    var futureBuilder = FutureBuilder(
      future: db.viewTheProcess(widget.idOfProcess),
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
              return getProcess(context, snapshot);
        }
      },
    );
    return Scaffold(
      body: futureBuilder,
    );
  }
  Widget getProcess(BuildContext context, AsyncSnapshot snapshot){
    List addNum = snapshot.data;
    final bool editEnable = false;
    String from = addNum[1];
    String to = addNum[2];
    int money = addNum[3];
    String date = addNum[4];
    String description = addNum[5];
    TextEditingController fromController = TextEditingController(text: "$from");
    TextEditingController toController = TextEditingController(text: "$to");
    TextEditingController moneyController = TextEditingController(text: "$money");
    TextEditingController dateController = TextEditingController(text: "$date");
    TextEditingController descriptionController = TextEditingController(text: "$description");
    return Scaffold(
      appBar: AppBar(
        title: Text("The Process"),
        backgroundColor: Colors.grey[800],
      ),
      body: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  /*Container(
                    child: SizedBox(
                        child: Image(
                          image: ExactAssetImage('assets/addprocess.jpeg'),
                          height: 230,
                          width: double.infinity,
                        )),
                  ),*/
                  Row(
                    children: <Widget>[
                      Padding(
                          padding:
                          const EdgeInsets.only(top: 30, left: 10, right: 10),
                          child: Padding(
                            padding:
                            const EdgeInsets.only(top: 30, left: 20, right: 7),
                            child: Icon(Icons.person, color: Colors.black),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: SizedBox(
                          child: Container(
                            child: TextFormField(
                              enabled: editEnable,
                              controller: fromController,
                              cursorColor: Colors.teal,
                              decoration: InputDecoration(
                                  labelText: ' From',
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 17,
                                      decorationColor: Colors.teal)),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter the name';
                                }
                                return null;
                              },
                            ),
                          ),
                          width: 270,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                          padding:
                          const EdgeInsets.only(top: 30, left: 10, right: 10),
                          child: Padding(
                            padding:
                            const EdgeInsets.only(top: 10, left: 20, right: 7),
                            child: Icon(Icons.person_pin, color: Colors.black),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: SizedBox(
                          child: Container(
                            child: TextFormField(
                              enabled: editEnable,
                              controller: toController,
                              cursorColor: Colors.teal,
                              decoration: InputDecoration(
                                  labelText: ' To',
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 17,
                                      decorationColor: Colors.teal)),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter the name';
                                }
                                return null;
                              },
                            ),
                          ),
                          width: 270,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                          padding:
                          const EdgeInsets.only(top: 30, left: 10, right: 10),
                          child: Padding(
                            padding:
                            const EdgeInsets.only(top: 10, left: 20, right: 7),
                            child: Icon(Icons.attach_money, color: Colors.black),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: SizedBox(
                          child: Container(
                            child: TextFormField(
                              enabled: editEnable,
                              controller: moneyController,
                              cursorColor: Colors.teal,
                              decoration: InputDecoration(
                                  labelText: ' Money',
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 17,
                                    decorationColor: Colors.teal,
                                  )),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter the money';
                                }
                                return null;
                              },
                            ),
                          ),
                          width: 270,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                          padding:
                          const EdgeInsets.only(top: 30, left: 10, right: 10),
                          child: Padding(
                            padding:
                            const EdgeInsets.only(top: 10, left: 20, right: 7),
                            child: Icon(Icons.attach_money, color: Colors.black),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: SizedBox(
                          child: Container(
                            child: TextFormField(
                              enabled: editEnable,
                              controller: dateController,
                              cursorColor: Colors.teal,
                              decoration: InputDecoration(
                                  labelText: ' date',
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 17,
                                    decorationColor: Colors.teal,
                                  )),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter the date';
                                }
                                return null;
                              },
                            ),
                          ),
                          width: 270,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                          padding:
                          const EdgeInsets.only(top: 30, left: 10, right: 10),
                          child: Padding(
                            padding:
                            const EdgeInsets.only(top: 10, left: 20, right: 7),
                            child: Icon(Icons.description, color: Colors.black),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: SizedBox(
                          child: Container(
                            child: TextFormField(
                              enabled: editEnable,
                              controller: descriptionController,
                              cursorColor: Colors.teal,
                              decoration: InputDecoration(
                                  labelText: ' Description',
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 17,
                                      decorationColor: Colors.teal)),
                              maxLines: 4,
                            ),
                          ),
                          width: 270,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
                        child: RaisedButton(
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(35.0),
                              side: BorderSide(color: Colors.brown)),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => EditProcess(widget.idOfProcess),),);
                          },
                          child: SizedBox(
                            child: Text(
                              "Edit",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            height: 25,
                            width: 100,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
                        child: RaisedButton(
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(35.0),
                              side: BorderSide(color: Colors.brown)),
                          onPressed: () {
                            showAlertDialog(context);
                          },
                          child: SizedBox(
                            child: Text(
                              "Delete",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            height: 25,
                            width: 100,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
