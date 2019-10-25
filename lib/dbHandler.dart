import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'model/project.dart';
import 'dart:convert';

class DBHandler {
  DBHandler._();
  static final DBHandler db = DBHandler._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "DyiManager.db";
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE project("
          "id INTEGER PRIMARY KEY,"
          "title TEXT,"
          "duration INTEGER,"
          "costs INTEGER"
          ")");
    });
  }

  Project projectFromJson(String str) {
    final jsonData = json.decode(str);
    return Project.fromJson(jsonData);
  }

  String projectToJson(Project data) {
    final dyn = data.toJson();
    return json.encode(dyn);
  }

  Future<int> newProject(Project newProject) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM project");
    int id = table.first["id"];
    newProject.id = id;
    var res = await db.insert("project", newProject.toJson());
    return res;
  }

  Future<Project> getProject(int id) async {
    final db = await database;
    var res = await db.query("project", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Project.fromJson(res.first) : Null ;
  }

  Future<List<Project>> getAllProjects() async {
    final db = await database;
    var res = await db.query("project");
    List<Project> list =
    res.isNotEmpty ? res.map((c) => Project.fromJson(c)).toList() : [];
    return list;
  }

  Future<int> updateProject(Project newProject) async {
    final db = await database;
    var res = await db.update("project", newProject.toJson(),
        where: "id = ?", whereArgs: [newProject.id]);
    return res;
  }

  Future<int> deleteProject(int id) async {
    final db = await database;
    db.delete("project", where: "id = ?", whereArgs: [id]);
  }

}