import '../model/User.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserDatabaseHelper {
  static final UserDatabaseHelper instance = UserDatabaseHelper._init(); 

  static Database? _database;

  UserDatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('user.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE users (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, phone TEXT, avatar TEXT, dateOfBirth TEXT)');
    await _insertDefaultUser(db);
  }

  Future<void> _insertDefaultUser(Database db) async {
    final List<Map<String, dynamic>> user = [
      {
        'name': 'John Doe',
        'email': 'john.doe@example.com',
        'phone': '1234567890',
        'avatar': 'https://i.pinimg.com/736x/65/33/35/653335b98154d8ce727ce2dbec41b398.jpg',
        'dateOfBirth': DateTime.now().toIso8601String(),
      },
      {
        'name': 'Jane Doe',
        'email': 'jane.doe@example.com',
        'phone': '0987654321',
        'avatar': 'https://i.pinimg.com/736x/5e/4c/f3/5e4cf3cd0b1abe4c6aeaab31eddcb483.jpg',
        'dateOfBirth': DateTime.now().toIso8601String(),
      },
      {
        'name': 'Jim Doe',
        'email': 'jim.doe@example.com',
        'phone': '1111111111',
        'avatar': 'https://i.pinimg.com/1200x/ab/2d/90/ab2d9009fb45decfc3f656ae71e15d69.jpg',
        'dateOfBirth': DateTime.now().toIso8601String(),
      },
    ];
    for (final user in user) {
      await db.insert('users', user);
    }
  }

  Future close() async {
    final db = await instance.database;
    await db.close();
  }

  Future<List<User>> getUsers() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) => User.fromMap(maps[i]));
  }

  Future<User> getUser(int id) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('users', where: 'id = ?', whereArgs: [id]);
    return User.fromMap(maps.first);
  }

  Future<int> insertUser(User user) async {
    final db = await instance.database;
    return await db.insert('users', user.toMap());
  }

  Future<int> updateUser(User user) async {
    final db = await instance.database;
    return await db.update('users', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  }

  Future<int> deleteUser(int id) async {
    final db = await instance.database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }
}