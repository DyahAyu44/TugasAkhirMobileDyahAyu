import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'mobil.dart';
import 'supir.dart';

//class DbHelper
class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;
  DbHelper._createObject();
  Future<Database> initDb() async {
    //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'sewaMobil.db';
    //create, read databases
    var itemDatabase = openDatabase(path, version: 4, onCreate: _createDb);
    //mengembalikan nilai object sebagai hasil dari fungsinya
    return itemDatabase;
  }

  //buat tabel baru dengan nama mobil
  void _createDb(Database db, int version) async {
    //tabel mobil
    await db.execute('''
CREATE TABLE mobil (
id INTEGER PRIMARY KEY AUTOINCREMENT,
merk TEXT,
type TEXT,
warna TEXT,
harga INTEGER,
stock INTEGER
)
''');
    //tabel supir
    await db.execute('''
CREATE TABLE supir (
id INTEGER PRIMARY KEY AUTOINCREMENT,
nama TEXT,
umur INTEGER,
alamat TEXT
)
''');
  }

  //select mobil databases
  Future<List<Map<String, dynamic>>> selectMobil() async {
    Database db = await this.initDb();
    var mapList = await db.query('mobil', orderBy: 'merk');
    return mapList;
  }

  //select supir databases
  Future<List<Map<String, dynamic>>> selectSupir() async {
    Database db = await this.initDb();
    var mapList = await db.query('supir', orderBy: 'nama');
    return mapList;
  }

  //insert mobil databases
  Future<int> insertMobil(Mobil object) async {
    Database db = await this.initDb();
    int count = await db.insert('mobil', object.toMap());
    return count;
  }

  //insert supir databases
  Future<int> insertSupir(Supir object) async {
    Database db = await this.initDb();
    int count = await db.insert('supir', object.toMap());
    return count;
  }

  //update mobil databases
  Future<int> updateMobil(Mobil object) async {
    Database db = await this.initDb();
    int count = await db
        .update('mobil', object.toMap(), where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  //update supir databases
  Future<int> updateSupir(Supir object) async {
    Database db = await this.initDb();
    int count = await db
        .update('supir', object.toMap(), where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  //delete mobil databases
  Future<int> deleteMobil(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('mobil', where: 'id=?', whereArgs: [id]);
    return count;
  }

  //delete supir databases
  Future<int> deleteSupir(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('supir', where: 'id=?', whereArgs: [id]);
    return count;
  }

  //list mobil
  Future<List<Mobil>> getMobilList() async {
    var mobilMapList = await selectMobil();
    int count = mobilMapList.length;
    List<Mobil> mobilList = List<Mobil>();
    for (int i = 0; i < count; i++) {
      mobilList.add(Mobil.fromMap(mobilMapList[i]));
    }
    return mobilList;
  }

  //list supir
  Future<List<Supir>> getSupirList() async {
    var supirMapList = await selectSupir();
    int count = supirMapList.length;
    List<Supir> supirList = List<Supir>();
    for (int i = 0; i < count; i++) {
      supirList.add(Supir.fromMap(supirMapList[i]));
    }
    return supirList;
  }

  factory DbHelper() {
    //kondisi jika dbhelper sama dengan null
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper; //mengembalikan nilai dari dbhelper
  }
  Future<Database> get database async {
    //kondisi jika database sama dengan null
    if (_database == null) {
      _database = await initDb();
    }
    return _database; //mengembalikan nilai dari database
  }
}
