import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
// Gunakan universal_html agar aman saat dicompile di mobile maupun web
import 'package:universal_html/html.dart' as html; 
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  static Database? _database;

  factory DbHelper() => _instance;

  DbHelper._internal();

  Future<Database?> get database async {
    if (kIsWeb) return null; // Jika web, tidak pakai sqflite
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'bimbel.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE pendaftaran(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama TEXT,
            kelas TEXT,
            foto_path TEXT,
            latitude REAL,
            longitude REAL
          )
        ''');
      },
    );
  }

  // === FUNGSI SIMPAN DATA (INSERT) ===
  Future<void> insertPendaftaran(Map<String, dynamic> data) async {
    if (kIsWeb) {
      // SOLUSI WEB: Simpan ke LocalStorage browser Chrome
      try {
        List<Map<String, dynamic>> dataLokal = await getPendaftaran();
        // Tambahkan id tiruan layaknya autoincrement
        data['id'] = dataLokal.length + 1; 
        dataLokal.add(data);
        
        html.window.localStorage['pendaftaran_data'] = jsonEncode(dataLokal);
        print("Web Storage: Berhasil menyimpan data ke LocalStorage");
      } catch (e) {
        print("Web Storage Error: $e");
      }
    } else {
      // SOLUSI MOBILE: Tetap pakai SQLite biasa
      final db = await database;
      await db?.insert(
        'pendaftaran',
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  // === FUNGSI AMBIL DATA (GET) ===
  Future<List<Map<String, dynamic>>> getPendaftaran() async {
    if (kIsWeb) {
      // SOLUSI WEB: Ambil dari LocalStorage browser Chrome
      try {
        String? jsonString = html.window.localStorage['pendaftaran_data'];
        if (jsonString == null || jsonString.isEmpty) return [];
        
        List<dynamic> decoded = jsonDecode(jsonString);
        return List<Map<String, dynamic>>.from(decoded);
      } catch (e) {
        print("Web Storage Read Error: $e");
        return [];
      }
    } else {
      // SOLUSI MOBILE: Ambil dari SQLite biasa
      final db = await database;
      if (db == null) return [];
      return await db.query('pendaftaran', orderBy: 'id DESC');
    }
  }
}