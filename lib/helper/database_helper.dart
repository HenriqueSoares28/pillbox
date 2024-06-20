import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'pillbox.db');
    
    // Delete the database for testing purposes to ensure a fresh creation
    //await deleteDatabase(path);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE remedios(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        cartNumber INTEGER,
        name TEXT,
        time TEXT,
        days TEXT
      )
    ''');
  }

  Future<int> insertRemedy(Map<String, dynamic> remedy) async {
    Database db = await database;
    return await db.insert('remedios', remedy, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateRemedy(Map<String, dynamic> remedy) async {
    Database db = await database;
    int cartNumber = remedy['cartNumber'];
    return await db.update('remedios', remedy, where: 'cartNumber = ?', whereArgs: [cartNumber]);
  }

  Future<Map<String, dynamic>> getRemedyByCompartment(int compartmentNumber) async {
    Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'remedios',
      where: 'cartNumber = ?',
      whereArgs: [compartmentNumber],
    );
    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {
        'name': 'N/A',
        'time': 'N/A',
        'days': 'N/A',
      };
    }
  }

  Future<List<Map<String, dynamic>>> getRemedios() async {
    Database db = await database;
    return await db.query('remedios');
  }

  Future<int> deleteRemedy(int cartNumber) async {
    Database db = await database;
    return await db.delete('remedios', where: 'cartNumber = ?', whereArgs: [cartNumber]);
  }
}
