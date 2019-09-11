import 'package:sqflite/sqflite.dart';

class DBService {
  DBService(String dbName) {
    this.mDbName = dbName;
  }

  Database db;
  String mDbName;

  open() async {
    if (db == null) {
      db = await openDatabase('$mDbName.db');
    }
  }

  close() async {
    if (db != null) {
      await db.close();
    }
  }

  exec(String sql) async {
    if (db == null) return null;
    return await db.execute(sql);
  }
}

enum DBServiceType {
  CodeWarsHistory,
}
