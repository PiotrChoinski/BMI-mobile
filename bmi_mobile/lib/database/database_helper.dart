import 'package:bmi_mobile/model/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _database;

  DatabaseHelper._instance();

  Future<Database> get db async {
    _database ??= await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'database.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        surname TEXT,
        birthday TEXT,
        height INTEGER,
        weight INTEGER,
        gender TEXT
      )
    ''');
  }

  Future<int> addUser(User user) async {
    Database db = await instance.db;
    return await db.insert('users', user.toMap());
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    Database db = await instance.db;
    return await db.query('users');
  }

  Future<int> updateUser(User user) async {
    Database db = await instance.db;
    return await db
        .update('users', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  }

  Future<int> deleteUser(int id) async {
    Database db = await instance.db;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  // Future<void> initializeUsers() async {
  //   List<User> usersToAdd = [
  //     User(
  //         name: 'Tomasz',
  //         surname: 'Ogrodnik',
  //         birthday: DateTime(1995, 1, 1),
  //         height: 180.0,
  //         weight: 80.0,
  //         gender: 'man')
  //   ];

  //   for (User user in usersToAdd) {
  //     await insertUser(user);
  //   }
  // }
}
