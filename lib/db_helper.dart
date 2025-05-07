import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:local_storage/task_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Database? _database;
  static getInstance() async {
    // if (_database == null) {
    //   _database = await _initDB(dbName: 'task.db');
    //   //you can write this line ==>

    // }
    // this line is switch to the top bloc of if condition
    _database ??= await _initDB(dbName: 'task.db');

    return _database;
  }

  Future insertTask(TaskModel task) async {
    final db = await getInstance();
    return db!.insert("tasks", task.toMap());
  }

  Future<List<TaskModel>> getTasks() async {
    final db = await getInstance();
    final List<Map<String, dynamic>> maps = await db.query("tasks");
    for (var map in maps) {
    log("Task Map: $map");
  }
    return List.generate(
        maps.length, (index) => TaskModel.fromMap(maps[index]));
  }

  Future updateTask(TaskModel updateTask) async {
    final db = await getInstance();
    return db.update(
      "tasks",
      updateTask.toMap(),
      where: "id=?",
      whereArgs: [updateTask.id],
    );
  }

  Future deleteTask(int id) async {
    final db = await getInstance();
    return db.delete(
      "tasks",
      where: "id=?",
      whereArgs: [id],
    );
  }

  static Future<Database> _initDB({required String dbName}) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, dbName);
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) => _onDBCreate(db),
    );
  }

  static Future<void> _onDBCreate(Database db) async {
    String taskTableQuery = '''
    CREATE TABLE tasks(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      isCompleted INTEGER NOT NULL,
      date Text
    )
    ''';
    await db.execute(taskTableQuery);
  }

  static Future<void> closeDB() async {
    final db = await getInstance();
    db.close();
  }
}
