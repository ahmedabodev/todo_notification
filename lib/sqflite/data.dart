import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CreateDataBaseController extends GetxController {
  changedatatime(value){
    datetime=value;
    getDatabase(database);
    update();
  }
  CreateDataBaseController(){
    getDatabase(database);
  }
  Database? database;
  String? path;
  void createDatabase() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
     path = join(databasesPath, 'todo.db');

    // open the database
    database = await openDatabase(path!, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      debugPrint('DataBase is created');
      await db.execute(
          'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, start TEXT,end TEXT,remind TEXT,repeat TEXT,color INTEGER ,state INTEGER)');
    }, onOpen: (Database db) {
      debugPrint('DataBase is opened');
      database=db;

      getDatabase(db);
      update();
    });
  }

  void insertIntoDatabase({
  required String title,
  required String date,
  required String start,
  required String end,
  required String remind,
  required String repeat,
  required int color,
  required int state,
})async{

    // Insert some records in a transaction
    await  database!.transaction((txn) async {
      var num = await txn.rawInsert(
          'INSERT INTO Tasks(title,date, start,end,remind,repeat,color,state) VALUES("$title","$date", "$start","$end","$remind","$repeat",$color,$state)');
      print('inserted1: $num');
      getDatabase(database);
    });

  }

var datetime=DateFormat('yyyy-MM-dd ').format(DateTime.now());
  List<Map> list=[];
  List<Map>listbydate=[];
  void getDatabase(database)async{
    // Get the records
  list=  await database!.rawQuery('SELECT * FROM Tasks');
    // print(list);
listbydate=await database!.query('Tasks', where: '"date" = ?', whereArgs: [datetime]);
print('------------------------');
print('ahmed'+listbydate.toString());
  print('------------------------');

update();


  }


  void updateDatabase({
  required int id,
  required int state,
})async{

    // Update some record
    database!.rawUpdate('UPDATE tasks SET state = ? WHERE id = ?',
        [state, id]);
    print('updated: ');
    getDatabase(database);

  }


  void deleteFromDatabase({required int id})async{

    // Delete a record
      await database!.rawDelete('DELETE FROM Tasks WHERE id = ?', [id]);
      getDatabase(database);


  }

  void deleteAllData()async{
    // Delete the database
     await deleteDatabase(path!);
     createDatabase();

  }

  int? currentIndex;
  bool? isCheck=false;
  void onChange( value){
    value=!value;
    if(value==false){
      currentIndex=1;
    }else{
      currentIndex=0;

    }
    update();
  }

}
