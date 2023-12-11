// import 'package:flutter/material.dart';
// import 'package:notes_app/data/model/notes_model.dart';
// import 'package:notes_app/utils/encrypt.dart';
// import 'package:sqflite_sqlcipher/sqflite.dart';

// class DataBaseHelper {
//   static DataBaseHelper? _dataBaseHelper;

//   DataBaseHelper._instance() {
//     _dataBaseHelper = this;
//   }

//   factory DataBaseHelper() => _dataBaseHelper ?? DataBaseHelper._instance();

//   static Database? _database;

//   Future<Database?> get database async {
//     _database ??= await initDb();
//     return _database;
//   }

//   static const String _noteTable = 'notes';

//   Future<Database> initDb() async {
//     final path = await getDatabasesPath();
//     final databasePath = '$path/notes.db';

//     debugPrint(databasePath);

//     var db = await openDatabase(databasePath,
//         version: 1,
//         onCreate: _onCreate,
//         password: encrypt('Your secure password'));
//     return db;
//   }

//   void _onCreate(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE $_noteTable(
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         title TEXT,
//         body TEXT,
//         colorValue INTEGER,
//         createdAt TEXT DEFAULT CURRENT_TIMESTAMP
//       );
//     ''');
//   }

//   void close() async {
//     final db = await database;
//     db!.close();
//   }

//   Future<int> create(NoteModel notes) async {
//     final db = await database;
//     return await db!.insert(_noteTable, notes.toJson(),
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }

//   Future<int> update(NoteModel notes) async {
//     final db = await database;
//     return await db!.update(
//       _noteTable,
//       notes.toJson(),
//       where: "id = ?",
//       whereArgs: [notes.id],
//     );
//   }

//   Future<int> delete(int id) async {
//     final db = await database;
//     return await db!.delete(
//       _noteTable,
//       where: "id = ?",
//       whereArgs: [id],
//     );
//   }

//   Future<Map<String, dynamic>?> getNoteById(int id) async {
//     final db = await database;
//     final result = await db!.query(
//       _noteTable,
//       where: "id = ?",
//       whereArgs: [id],
//     );

//     if (result.isNotEmpty) {
//       return result.first;
//     } else {
//       return null;
//     }
//   }

//   Future<List<Map<String, dynamic>>> getAllNotes() async {
//     final db = await database;
//     final data = await db!.query(_noteTable);
//     return data;
//   }
// }
