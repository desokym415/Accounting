import 'package:flutter/material.dart';
import 'dart:core';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                          height: 260,
                          width: double.infinity,
                        )),
                  ),
                  Text(
                    "SIGN IN",
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
                          width: 280,
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
                          width: 280,
                        ),
                      )
                    ],
                  ),
                  InkWell(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 6, left: 170),
                        child: Text(
                          "create new account ?",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      onTap: () {Navigator.pushNamed(context, '/createaccount');}),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
                    child: RaisedButton(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(35.0),
                          side: BorderSide(color: Colors.brown)),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {}
                        Navigator.pushNamed(context, '/userhome');
                      },
                      child: SizedBox(
                        child: Text(
                          "Sign In",
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

