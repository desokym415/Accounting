import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:accountin/appclasses/user.dart';
import 'package:accountin/databasehelper/DataBaseHelper.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _formKey = GlobalKey<FormState>();
  DataBaseHelper db = DataBaseHelper();
  User user;
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    child: SizedBox(
                        child: Image(
                          image: ExactAssetImage('assets/Login_img.jpg'),
                          height: 250,
                          width: double.infinity,
                        )),
                  ),
                  Text(
                    "SIGN UP",
                    style: TextStyle(
                        fontSize: 30,
                        fontStyle: FontStyle.italic,
                        color: Colors.black),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 30, left: 20, right: 10),
                          child: Icon(
                            Icons.person,
                            color: Colors.black,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: SizedBox(
                          child: Container(
                            child: TextFormField(
                              controller: nameController,
                              cursorColor: Colors.teal,
                              decoration: InputDecoration(
                                  labelText: ' Enter the Username',
                                  labelStyle: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 17,
                                      decorationColor: Colors.teal)),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your username';
                                }
                                return null;
                              },
                            ),
                          ),
                          width: 290,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 30, left: 20, right: 10),
                          child: Icon(
                            Icons.lock,
                            color: Colors.black,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 9),
                        child: SizedBox(
                          child: Container(
                            child: TextFormField(
                              controller: passController,
                              cursorColor: Colors.teal,
                              decoration: InputDecoration(
                                  labelText: ' Enter the Password',
                                  labelStyle: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 17,
                                      decorationColor: Colors.teal)),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                          ),
                          width: 290,
                        ),
                      )
                    ],
                  ),  Row(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 30, left: 20, right: 10),
                          child: Icon(
                            Icons.lock,
                            color: Colors.black,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 9),
                        child: SizedBox(
                          child: Container(
                            child: TextFormField(
                              controller: confirmPassController,
                              cursorColor: Colors.teal,
                              decoration: InputDecoration(
                                  labelText: ' confirm password',
                                  labelStyle: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 17,
                                      decorationColor: Colors.teal)),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'please enter password';
                                }
                                return null;
                              },
                            ),
                          ),
                          width: 290,
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
                        if (_formKey.currentState.validate()) {
                          if(passController.text == confirmPassController.text){
                          user = User(userName: nameController.text,userPassword: passController.text);
                          //db.insertUser(user);
                           }
                          else print("password conflict");
                        }
                        },
                      child: SizedBox(
                        child: Text(
                          "Sign UP",
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
                  Row(children: <Widget>[ Padding(
                    padding: const EdgeInsets.only(left: 80,top: 6),
                    child: Text("Have already account ?",
                        style: TextStyle(color: Colors.grey)),
                  ),
                    InkWell(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 6, left: 3),
                          child: Text(
                            "Login here",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        onTap: () {Navigator.pop(context);}),],)
                ],
              ),
            ),
          )),
    );
  }
}
