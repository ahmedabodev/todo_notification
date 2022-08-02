import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CreateDataBaseControllerprivate extends GetxController {


  CreateDataBaseControllerprivate(){
    createDatabase();
  }
  Database? database;
  String? path;
  void createDatabase() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    path = join(databasesPath, 'todoPrivate.db');

    // open the database
    database = await openDatabase(path!, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          debugPrint('DataBase is created');
          await db.execute(
              'CREATE TABLE TasksPrivate (id INTEGER PRIMARY KEY, title TEXT, date TEXT, start TEXT,color INTEGER ,note TEXT,favorite INTEGER,password TEXT)');
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
    required int color,
    required String note,
    required String password,
    required int favorite,
  })async{

    // Insert some records in a transaction
    await  database!.transaction((txn) async {
      var num = await txn.rawInsert(
          'INSERT INTO TasksPrivate(title,date,start,color,note,favorite,password) VALUES("$title","$date", "$start",$color,"$note",$favorite,"$password")');
      print('inserted1: $num');
      getDatabase(database);
    });

  }


  List<Map> privatelist=[];
  List<Map>privatelistfav=[];
  void getDatabase(database)async{
    // Get the records
    privatelist=  await database!.rawQuery('SELECT * FROM TasksPrivate');
    // print(list);
    privatelistfav=await database!.query('TasksPrivate', where: '"favorite" = ?', whereArgs: [1]);
    print('------------------------');
    privatelist=  await database!.rawQuery('SELECT * FROM TasksPrivate');

    print('------------------------');

    update();


  }


  void updateDatabase({
    required int id,
    required int state,
  })async{

    // Update some record
    database!.rawUpdate('UPDATE TasksPrivate SET state = ? WHERE id = ?',
        [state, id]);
    print('updated: ');
    getDatabase(database);

  }



  void updateDatabasefavorite({
    required int id,
    required int favorite,
  })async{

    // Update some record
    database!.rawUpdate('UPDATE TasksPrivate SET favorite = ? WHERE id = ?',
        [favorite, id]);
    print('updated: ');
    getDatabase(database);

  }


  void deleteFromDatabase({required int id})async{

    // Delete a record
    await database!.rawDelete('DELETE FROM TasksPrivate WHERE id = ?', [id]);
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
