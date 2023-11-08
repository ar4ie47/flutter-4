import 'dart:collection';

import 'package:anki/model/card.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'common.dart';

const String tableName = 'Card';
const String translateColumn = 'translate';
const String folderIdColumn = 'folderId';
const String wordColumn = 'word';
const String idColumn = 'id';

class CardRepository {
  CardRepository._();

  static final CardRepository db = CardRepository._();
  static Database? _database;

  Future<Database> get database async {
    return _database ?? await _initDB();
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
        "$wordColumn text,"
        "$folderIdColumn integer,"
        "$translateColumn text)");
    // (await database.query('sqlite_master', columns: ['type', 'name']))
    //     .forEach((row) {
    //   print(row.values);
    // });
    return database;
  }

  Future<ListQueue<CardModel>> getQueue(int folderId) async {
    var list = await getAll();
    var result = list.where((element) => element.folderId == folderId).toList();
    result.shuffle();
    return ListQueue.of(result);
  }

  void deleteDatabase() async {
    final databasesPath = await getApplicationDocumentsDirectory();
    var path = "$databasesPath/$appDbName";
    await databaseFactory.deleteDatabase(path);
  }

  Future<List<CardModel>> getAll() async {
    var db = await database;
    return await db
        .query(tableName)
        .then((value) => value.map((e) => CardModel.fromJson(e)).toList());
  }

  Future<CardModel> insert(CardModel item) async {
    var db = await database;
    item.id = await db.insert(tableName, item.toJson());
    return item;
  }

  void delete(int id) async {
    var db = await database;
    await db.delete(tableName, where: '$idColumn = ?', whereArgs: [id]);
  }

  void update(CardModel item) async {
    var db = await database;
    await db.update(tableName, item.toJson(),
        where: '$idColumn = ?', whereArgs: [item.id]);
  }

  Future close() async => _database!.close();
}
