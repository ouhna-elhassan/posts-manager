import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../data/models.dart';
import 'package:fluttertoast/fluttertoast.dart';
  
  
  
  Future<void> addToDataBase(String id,String text,var path) async{
    final database = openDatabase(
      join(await getDatabasesPath(), 'posts.db'),
      onCreate: (db,version){
        return db.execute(
            'CREATE TABLE posts(id TEXT PRIMARY KEY, text TEXT,path TEXT)'
        );
      },
      version: 1,
    );

    final db =await database;
    Fluttertoast.showToast(msg:  ' db');
    await db.insert(
    'posts',
    PostOffline(
      id: id,
      text: text,
      path: path.toString(),
    ).toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
    );
    Fluttertoast.showToast(msg:  'added to db');
  }

  Future<List<PostOffline>> getStoredPosts() async {
    // Get a reference to the database.
    final database = openDatabase(
      join(await getDatabasesPath(), 'posts.db'),
      onCreate: (db,version){
        return db.execute(
            'CREATE TABLE posts(id TEXT PRIMARY KEY, text TEXT,path TEXT)'
        );
      },
      version: 1,
    );
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('posts');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return PostOffline(
        id: maps[i]['id'],
        text: maps[i]['text'],
        path: maps[i]['path'],
      );
    });
  }