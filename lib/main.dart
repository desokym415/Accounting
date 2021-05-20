import 'package:accountin/pages/addprocess.dart';
import 'package:accountin/pages/createaccount.dart';
import 'package:accountin/pages/userhome.dart';
import 'package:flutter/material.dart';
import 'package:accountin/pages/home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
  initialRoute: '/home',
  routes: {
    //'/' : (context) => Home(),
    '/home': (context) => Home(),
    '/createaccount' : (context) => CreateAccount(),
    '/userhome' : (context) => UserHome(),
    '/addprocess' : (context) => AddProcess(),
  },
)
  );
}
