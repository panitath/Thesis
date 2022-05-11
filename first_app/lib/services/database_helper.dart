

import 'package:first_app/model/authen_api_model.dart';
import 'package:first_app/model/leave_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart';

class DBLHelper {
  static final _databaseName = "timemanagement.db";
  static final _databaseVersion = 1;
  static final _tableName = 'user';

  DBLHelper._();
  static final DBLHelper instance = DBLHelper._();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static const tableUser = """
  CREATE TABLE IF NOT EXISTS user (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          id_card TEXT NULL,
          user_type INTEGER NULL,
          emp_code TEXT NULL,
          fname TEXT NULL,
          lname TEXT NULL,
          position_name TEXT NULL,
          email TEXT NULL,
          tel TEXT NULL,
          group_code TEXT NULL,
          group_name TEXT NULL,
          field_code TEXT NULL,
          field_name TEXT NULL,
          dept_code TEXT NULL,
          dept_name TEXT NULL,
          center_code TEXT NULL,
          center_name TEXT NULL,
          zone_code TEXT NULL,
          zone_name TEXT NULL,
          division_code TEXT NULL,
          division_name TEXT NULL,
          sol_code TEXT NULL,
          sol_name TEXT NULL,
          stop_date TEXT NULL,
          token TEXT NULL,
          refreshToken TEXT NULL,
          createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      );""";

  _initDatabase() async {
    //Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path =  join(await getDatabasesPath(), _databaseName);
    print("path :" + path);
    await deleteDatabase(path);
    return await openDatabase(path, version: _databaseVersion,
        onCreate: (Database db, int version) async {
      await db.execute(tableUser);
    });
  }

  static Future<int> insertUserEmpployee(AuthenModel model) async {
    Database db = await instance.database;
    final data = {
      'id_card': '0000000000000',
      'user_type': 1,
      'emp_code': model.employee?.emp_code,
      'fname': model.employee?.fname,
      'lname': model.employee?.lname,
      'position_name': model.employee?.position_name,
      'email': model.employee?.email,
      'tel': model.employee?.tel,
      'group_code': model.employee?.group_code,
      'group_name': model.employee?.group_name,
      'field_code': model.employee?.field_code,
      'field_name': model.employee?.field_name,
      'dept_code': model.employee?.dept_code,
      'dept_name': model.employee?.dept_name,
      'center_code': model.employee?.center_code,
      'center_name': model.employee?.center_name,
      'zone_code': model.employee?.zone_code,
      'zone_name': model.employee?.zone_name,
      'division_code': model.employee?.division_code,
      'division_name': model.employee?.division_name,
      'sol_code': model.employee?.sol_code,
      'sol_name': model.employee?.sol_name,
      'stop_date': model.employee?.stop_date,
      'token': model.token,
      'refreshToken': model.refreshToken,
    };
    final id = await db.insert(_tableName, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getEmployee() async {
    Database db = await instance.database;
    return db.query(_tableName, where: "id = ?", whereArgs: [1], limit: 1);
  }

  static Future<Users?> getEmployeeById() async {
    Database db = await instance.database;
    List<Map> maps = await db.query(_tableName,
        columns: [
          "emp_code",
          "fname",
          "lname",
          "position_name",
          "email",
          "tel",
          "group_code",
          "group_name",
          "field_code",
          "field_name",
          "dept_code",
          "dept_name",
          "center_code",
          "center_name",
          "zone_code",
          "zone_name",
          "division_code",
          "division_name",
          "sol_code",
          "sol_name",
          "stop_date",
          "token",
          "refreshToken",
          "id_card",
          "user_type",
        ],
        where: 'id = ?',
        whereArgs: [1]);
    if (maps.length > 0) {
      return Users.fromMapObject(maps.first);
    }
    return null;
  }

  static Future<List> getToken() async {
    Database db = await instance.database;
    var list =
    await db.rawQuery('SELECT token,refreshToken FROM user');
    print(list);
    return list;
  }

  static Future<int> updateItem(
      int id, String title, String? descrption) async {
    Database db = await instance.database;
    final data = {
      'title': title,
      'description': descrption,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update(_tableName, data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<int> delete() async {
    Database db = await instance.database;
    return await db
        .delete(_tableName); //where: '$columnId = ?', whereArgs: [id]);
  }
}
