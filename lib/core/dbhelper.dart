import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/asset_model.dart';

class DatabaseHelper {
  static const _databaseName = 'assets.db';
  static const _databaseVersion = 1;

  static const table = 'assets';
  static const columnId = 'id';
  static const columnName = 'name';
  static const columnType = 'type';
  static const columnDescription = 'description';
  static const columnAvailability = 'availability';

  // Singleton pattern
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Database instance
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  // Open the database
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  // Create tables
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnName TEXT NOT NULL,
        $columnType TEXT NOT NULL,
        $columnDescription TEXT,
        $columnAvailability TEXT NOT NULL
      )
    ''');
  }

  // Insert an asset into the database
  Future<int> insert(Asset asset) async {
    Database db = await instance.database;
    return await db.insert(table, asset.toMap());
  }

  // Fetch all assets from the database
  Future<List<Asset>> queryAllAssets() async {
    Database db = await instance.database;
    var result = await db.query(table);
    return result.map((map) => Asset.fromMap(map)).toList();
  }

  // Update an existing asset
  Future<int> update(Asset asset) async {
    Database db = await instance.database;
    return await db.update(
      table,
      asset.toMap(),
      where: '$columnId = ?',
      whereArgs: [asset.id],
    );
  }

  // Delete an asset
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
