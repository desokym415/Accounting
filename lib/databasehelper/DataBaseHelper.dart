import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:accountin/appclasses/process.dart';
class DataBaseHelper {
  //process table
  String processTable ="processes", idOfProcess = "processid", idOfUser = "user_id", from1 = "fromone", to2 = "toanother", processMoney = "money", processDate = "date", processDescription = "description";
  static DataBaseHelper _databaseHelper;
  static Database _database;
  DataBaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper
  factory DataBaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DataBaseHelper._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDb();

    }
    return _database;
  }
  Future<Database> initializeDb() async {
    var dbPath = await getDatabasesPath();
    final Future<Database> database = openDatabase(
      join(dbPath, 'accountingDB33.db'),
      onCreate: (db, version) {
        db.execute("CREATE TABLE $processTable($idOfProcess INTEGER PRIMARY KEY,$from1 TEXT, $to2 TEXT, $processMoney INTEGER,$processDate ,$processDescription TEXT);");
        return db;
      },
      version: 2,
    );
    return database;
  }
  Future<void> insertProcess(Process process) async {
    final Database db = await this.database;
    await db.insert(
      'processes',
      process.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
  Future<void> deleteProcess(int id) async {
    final Database db = await this.database;
    await db.rawQuery("DELETE FROM $processTable WHERE $idOfProcess =$id;");
  }
  Future<List<Map<String, dynamic>>> viewTheProcessOfPerson(String clientName, String secondPerson) async {
    final Database db = await database;
    var result = await db.rawQuery("SELECT * FROM $processTable WHERE ($from1 = '$clientName' AND $to2 = '$secondPerson') OR ($from1 = '$secondPerson' AND $to2 = '$clientName') ");
    return result;
  }
  Future<int> theTotalFT(String clientName,String anotherName) async {
    final Database db = await database;
    var sum = 0 ;
    var result = await db.rawQuery("SELECT $processMoney FROM $processTable WHERE $from1 = '$anotherName' AND $to2 = '$clientName'");
    //print(result);
    List<int> addNum = List();
    for (var x in result) {
      x.forEach((k, v) => addNum.add(v));
    }
    var addNumbers = addNum.toList();
    for (int x in addNumbers){
      sum = sum + x;
    }
    return sum;
  }
  Future<int> theTotal(String clientName,String anotherName) async {
    final Database db = await database;
    var sum = 0 ;
    var result = await db.rawQuery("SELECT $processMoney FROM $processTable WHERE $from1 = '$clientName' AND $to2 = '$anotherName'");
    //print(result);
    List<int> addNum = List();
    for (var x in result) {
      x.forEach((k, v) => addNum.add(v));
    }
    var addNumbers = addNum.toList();
    for (int x in addNumbers){
      sum = sum + x;
    }
    return sum;
  }
  Future<List<Map<String, dynamic>>> allNames() async{
    final Database db = await this.database;
    var result = await db.rawQuery("SELECT DISTINCT	$from1,$to2 FROM $processTable;");
    return result;
  }
  Future<List> viewTheProcess(int id) async {
    final Database db = await database;
    var result = await db.rawQuery("SELECT * FROM $processTable WHERE $idOfProcess = $id");
    List allNames = List();
    for (var x in result) {
      x.forEach((k, v) => allNames.add(v));
    }
    allNames.toList();
    return allNames;
  }
  Future<List<String>> viewSpecialPersons(String clientName) async {
    final Database db = await database;
    var result = await db.rawQuery("SELECT $to2 FROM $processTable WHERE $from1 = '$clientName'");
    var result1 = await db.rawQuery("SELECT $from1 FROM $processTable WHERE $to2 = '$clientName'");
    List<String> allNames = List();
    for (var x in result) {
      x.forEach((k, v) => allNames.add(v));
    }
    for (var x in result1){
      x.forEach((k, v) => allNames.add(v));
    }
    var distinctAllNames = allNames.toSet().toList();
    return distinctAllNames;
  }
  Future<List<Map<String, dynamic>>> editProcess(int id, String from, String to, int money, String description) async{
    final Database db = await this.database;
    var result = await db.rawQuery("UPDATE $processTable SET $from1 = '$from', $to2 = '$to', $processMoney = '$money', $processDescription = '$description' WHERE $idOfProcess = $id ;");
    return result;
  }
}



