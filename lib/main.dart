
import 'package:asset_man/view/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize your database
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'assets.db');

  // Open the database and create the table if it doesn't exist
  await openDatabase(path, version: 1, onCreate: (db, version) {
    return db.execute(
      'CREATE TABLE assets(id INTEGER PRIMARY KEY, name TEXT, type TEXT, description TEXT, availability TEXT)',
    );
  });

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page with Add Asset',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}