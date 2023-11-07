import 'package:anki/model/folder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'common.dart';

const String tableName = 'Folder';
const String idColumn = 'id';
const String folderNameColumn = 'folderName';

class FolderRepository {
  FolderRepository._();

  static final FolderRepository db = FolderRepository._();
  static Database? _database;

  Future<Database> get database async {
    _database = _database ?? await _initDB();
    return _database!;
  }

  _initDB() async {
    final databasesPath = await getApplicationDocumentsDirectory();
    var path = "$databasesPath/$appDbName";
    var database = await openDatabase(path,
        version: 1,
        onOpen: (db) {},
        onCreate: (Database db, int version) async {});
    await database.execute("CREATE TABLE IF NOT EXISTS $tableName ("
        "$idColumn integer primary key autoincrement,"
        "$folderNameColumn text)");
    return database;
  }

  void deleteDatabase() async {
    final databasesPath = await getApplicationDocumentsDirectory();
    var path = "$databasesPath/$appDbName";
    await databaseFactory.deleteDatabase(path);
  }

  Future<List<FolderModel>> getAll() async {
    var db = await database;
    var then = db
        .query(tableName)
        .then((value) => value.map((e) => FolderModel.fromJson(e)).toList());
    return then;
  }

  Future<FolderModel> insert(FolderModel item) async {
    var db = await database;
    item.id = await db.insert(tableName, item.toJson());
    return item;
  }

  void delete(int id) async {
    var db = await database;
    await db.delete(tableName, where: '$idColumn = ?', whereArgs: [id]);
  }

  void deleteByName(String folderName) async {
    var db = await database;
    await db.delete(tableName,
        where: '$folderNameColumn = ?', whereArgs: [folderName]);
  }

  void update(FolderModel item) async {
    var db = await database;
    await db.update(tableName, item.toJson(),
        where: '$idColumn = ?', whereArgs: [item.id]);
  }

  Future<FolderModel> getById(int id) async {
    List<Map<String, dynamic>> maps = await _database!.query(tableName,
        columns: [id as String, folderNameColumn],
        where: '$id = ?',
        whereArgs: [id]);
    return FolderModel.fromJson(maps.first);
  }

  Future close() async => _database!.close();
}
