// import 'dart:convert';
//
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
//
// import '../model/grid_item.dart';
//
// const String tableName = 'GridItem';
// const String id = 'id';
// const String audio = 'audio';
// const String name = 'name';
// const String favorite = 'favorite';
//
// class GridItemRepository {
//   GridItemRepository._();
//
//   static final GridItemRepository db = GridItemRepository._();
//   static Database? _database;
//
//   Future<Database> get database async {
//     return _database ?? await _initDB();
//   }
//
//   _initDB() async {
//     final databasesPath = await getApplicationDocumentsDirectory();
//     var path = "$databasesPath/GridItemDB.db";
//     var database = await openDatabase(path, version: 1, onOpen: (db) {},
//         onCreate: (Database db, int version) async {
//       await db.execute("CREATE TABLE $tableName ("
//           "$id integer primary key autoincrement,"
//           "$audio text not null,"
//           "$name text not null,"
//           "$favorite integer default 0)");
//     });
//     return database;
//   }
//
//   void deleteDatabase() async {
//     final databasesPath = await getApplicationDocumentsDirectory();
//     var path = "$databasesPath/GridItemDB.db";
//     await databaseFactory.deleteDatabase(path);
//   }
//
//   Future<void> initData() async {
//     final String response =
//         await rootBundle.loadString("assets/json/grid_data2.json");
//
//     Iterable data = json.decode(response);
//     var items = List<GridItem>.from(
//         data.map((jsonObj) => GridItem.fromJson(jsonObj)));
//
//     var db = await database;
//     for (var element in items) {
//       db.insert(tableName, element.toJson());
//     }
//   }
//
//   Future<List<GridItem>> getAll() async {
//     var db = await database;
//     var then = db
//         .query(tableName)
//         .then((value) => value.map((e) => GridItem.fromJson(e)).toList());
//     return then;
//   }
//
//   Future<List<GridItem>> getFavorite(int favoriteValue) async {
//     var db = await database;
//     var query = await db.query(tableName,
//         columns: [id, name, audio, favorite],
//         where: '$favorite = ?',
//         whereArgs: [favoriteValue]);
//     return query.map((e) => GridItem.fromJson(e)).toList();
//   }
//
//   Future<GridItem> insert(GridItem item) async {
//     var db = await database;
//     item.id = db.insert(tableName, item.toJson()) as int;
//     return item;
//   }
//
//   Future<int> delete(int id) async {
//     return await _database!
//         .delete(tableName, where: '$id = ?', whereArgs: [id]);
//   }
//
//   void update(GridItem item) async {
//     var db = await database;
//     await db.update(tableName, item.toJson(),
//         where: '$id = ?', whereArgs: [item.id]);
//   }
//
//   Future<GridItem?> getById(int id) async {
//     List<Map<String, dynamic>> maps = await _database!.query(tableName,
//         columns: [id as String, name, audio],
//         where: '$id = ?',
//         whereArgs: [id]);
//     return maps.isNotEmpty ? GridItem.fromJson(maps.first) : null;
//   }
//
//   Future<List<GridItem?>> getByFavorite(bool isFavorite) async {
//     List<Map<String, dynamic>> maps = await _database!.query(tableName,
//         columns: [id, name, audio],
//         where: '$favorite = ?',
//         whereArgs: [isFavorite ? 1 : 0]);
//     return maps.isEmpty
//         ? List.empty()
//         : maps.map((e) => GridItem.fromJson(e)).toList();
//   }
//
//   Future close() async => _database!.close();
// }
