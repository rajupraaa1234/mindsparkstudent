import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:mindsparkstudent/models/User.dart';


class DatabaseHelper {

  DatabaseHelper._createInstance();
  static DatabaseHelper _databaseHelper = DatabaseHelper._createInstance();
  static Database? _database;


// user Table with Column
  String userTable = 'UserTable';
  String userId = 'userId';
  String userName = 'username';
  String password = 'password';


  factory DatabaseHelper(){
    if(_databaseHelper==null){
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database?> get database async {
    if(_database == null){
      _database = await initilizeDatabase();
    }
    return _database;
  }

 Future<Database> initilizeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'userDb';
    var userDb = await openDatabase(path,version: 1,onCreate: _createDb);
    return userDb;
  }

  void _createDb(Database db,int newVersion) async {
     await db.execute('CREATE TABLE $userTable($userName TEXT PRIMARY KEY , $password TEXT)');
  }

  Future<int?> insertNote(User user) async {
    var db = await this.database;
    var result = await db?.insert(userTable, user.toMap());
    print("res ----> $result");
    return result;
  }

  // List<Map> res = await database.rawQuery(
  // "SELECT * FROM sentences WHERE title LIKE '%${text}%' OR  body LIKE '%${text}%'");

  Future<Map<String, Object?>?> checkUserCredential(String userName, String password) async {
    var db = await this.database;
    var res = await db?.rawQuery(
        "SELECT * FROM $userTable WHERE username = '$userName' and password = '$password'");
    print('res----> $res');
    if (res!.length > 0) {
      var dbItem = res.first;
      return dbItem;
      // print("user ----->   ${dbItem}");
      // var newUser = new User(dbItem['username'] as String, dbItem['password'] as String);
      // return newUser;
    }
    return null;
  }

  Future<bool> isAlredayExistUSer(String user) async {
    var db = await this.database;
    var res = await db?.rawQuery(
        "SELECT * FROM $userTable WHERE username = '$user'");
    print("user exist -----> ${res!.length}");
    if(res.length>0) return Future<bool>.value(true);
    return  Future<bool>.value(false);
  }






}