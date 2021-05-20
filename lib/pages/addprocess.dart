import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:accountin/databasehelper/DataBaseHelper.dart';
import 'package:accountin/appclasses/process.dart';
import 'package:intl/intl.dart';
class AddProcess extends StatefulWidget {
  @override
  _AddProcessState createState() => _AddProcessState();
}

class _AddProcessState extends State<AddProcess> {
  final _formKey = GlobalKey<FormState>();
  DataBaseHelper db = DataBaseHelper();
  Process process;
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController moneyController= TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  void moveToLastScreen(){
    Navigator.pop(context, true);
  }

  var _todateController=TextEditingController() ;
  DateTime _datetime = DateTime.now();
  _selectedtodate(BuildContext context)async{
    var _pickedate=
    await showDatePicker(
        context: context, initialDate: _datetime, firstDate: DateTime(2000), lastDate: DateTime(2100));
    if (_pickedate !=null){setState(() {
      _datetime=_pickedate;
      _todateController.text=DateFormat('yyyy-MM-dd').format(_pickedate);
    });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Process'),
        centerTitle: true,
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
                          child:
                          Padding(
                            padding: const EdgeInsets.only(top: 30,left: 20 ,right: 7),
                            child: Icon(Icons.person ,color:Colors.black),
                          )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: SizedBox(
                          child: Container(
                            child: TextFormField(
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
                          child:
                          Padding(
                            padding: const EdgeInsets.only(top: 10,left: 20 ,right: 7),
                            child: Icon(Icons.person_pin,color:Colors.black),
                          )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: SizedBox(
                          child: Container(
                            child: TextFormField(
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
                          child:
                          Padding(
                            padding: const EdgeInsets.only(top: 10,left: 20 ,right: 7),
                            child: Icon(Icons.attach_money,color:Colors.black),
                          )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: SizedBox(
                          child: Container(
                            child: TextFormField(
                              controller: moneyController,
                              cursorColor: Colors.teal,
                              decoration: InputDecoration(
                                  labelText: ' Money',
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 17,
                                    decorationColor: Colors.teal,)),keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value.isEmpty ) {
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
                          child:
                          Padding(
                            padding: const EdgeInsets.only(top: 10,left: 20 ),
                            child: Icon(Icons.date_range,color:Colors.black),
                          )
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 10,top: 10),
                          child: SizedBox(
                              child: Container(
                                child: TextFormField(

                                  controller: _todateController,
                                  cursorColor: Colors.teal,
                                  decoration: InputDecoration(
                                    labelText: ' date',hintText: 'pick a date',
                                    labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 17,
                                        decorationColor: Colors.teal),prefix:  InkWell (onTap: (){
                                    _selectedtodate(context);},child: Icon(Icons.calendar_today ,color: Colors.black45,)

                                  ),
                                  ),

                                  validator: (value) {
                                    if (value.isEmpty ) {
                                      return 'Please enter the date';
                                    }
                                    return null;
                                  },
                                ),
                                width:280,

                              )))
                    ],
                  ),

                  Row(
                    children: <Widget>[
                      Padding(
                          padding:
                          const EdgeInsets.only(top: 30, left: 10, right: 10),
                          child:
                          Padding(
                            padding: const EdgeInsets.only(top: 10,left: 20 ,right: 7),
                            child: Icon(Icons.description,color:Colors.black),
                          )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: SizedBox(
                          child: Container(
                            child: TextFormField(
                              controller: descriptionController,
                              cursorColor: Colors.teal,
                              decoration: InputDecoration(
                                  labelText: ' Description',
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 17,
                                      decorationColor: Colors.teal)),maxLines: 4,
                            ),
                          ),
                          width: 270,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
                    child: RaisedButton(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(35.0),
                          side: BorderSide(color: Colors.brown)),
                      onPressed: () {
                        /*Future printallprocesses() async{
                          var values =await db.x();
                          print(values);
                        }*/
                        if(_formKey.currentState.validate()){
                          process = Process(fromOne: fromController.text, toAnother: toController.text, money: int.parse(moneyController.text),date: _todateController.text ,description: descriptionController.text);
                          db.insertProcess(process);
                          moveToLastScreen();
                          //printallprocesses();
                        }
                      },
                      child: SizedBox(
                        child: Text(
                          "Save",
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
            ),
          )),
    );
  }
}