import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class SQLHelper {
  static Database? _db;
  static const String _dbName = 'currency_converter.db';
  static const String _tableName = 'Rates';
  static const String _currenciesTableName = 'Currencies';

  /// Initialize the database
  static Future<void> initDB() async {
    try {
      String dbPath = await getDatabasesPath();
      String path = '$dbPath/$_dbName';

      _db = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE $_tableName (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              date TEXT,
              base TEXT,
              quote TEXT,
              rate REAL,
              amount REAL
            )
          ''');

          await db.execute('''
            CREATE TABLE $_currenciesTableName (
              iso_code TEXT PRIMARY KEY,
              iso_numeric TEXT,
              name TEXT,
              symbol TEXT,
              start_date TEXT
            )
          ''');
        },
      );
    } catch (e) {
      debugPrint("Error while initializing database: $e");
    }
  }

  /// Add Item
  static Future<int> insert(Map<String, Object?> values) async {
    try {
      int index = await _db!.insert(
        _tableName,
        values,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      debugPrint("Item inserted at index: $index");
      return index;
    } catch (e) {
      debugPrint("Error while inserting: $e");
      throw Exception("Error while inserting: $e");
    }
  }

  /// Retrieve Items filtered by Base Currency
  static Future<List<Map<String, dynamic>>> getItemsByBase(
    String baseCurrency,
  ) async {
    try {
      return await _db!.query(
        _tableName,
        where: 'base = ?',
        whereArgs: [baseCurrency],
      );
    } catch (e) {
      debugPrint("Error while retrieving: $e");
      throw Exception("Error while retrieving: $e");
    }
  }

  /// Retrieve All Items ordered by latest date
  static Future<List<Map<String, dynamic>>> getAllDBItems() async {
    try {
      return await _db!.query(_tableName, orderBy: 'date DESC');
    } catch (e) {
      debugPrint("Error while retrieving: $e");
      throw Exception("Error while retrieving all items: $e");
    }
  }

  /// Update Item
  static Future<bool> update(Map<String, Object?> values) async {
    try {
      await _db!.update(
        _tableName,
        {
          'date': values['date'],
          'base': values['base'],
          'quote': values['quote'],
          'rate': values['rate'],
        },
        where: 'id = ?',
        whereArgs: [values['id']],
      );
      return true;
    } catch (e) {
      debugPrint("Error while Updating: $e");
      throw Exception("Error while Updating: $e");
    }
  }

  /// Delete Item
  static Future<bool> delete(int id) async {
    try {
      int count = await _db!.delete(
        _tableName,
        where: 'id = ?',
        whereArgs: [id],
      );
      return count > 0;
    } catch (e) {
      debugPrint("Error while deleting: $e");
      throw Exception("Error while deleting: $e");
    }
  }

  static Future<void> insertCurrencies(
    List<Map<String, dynamic>> jsonList,
  ) async {
    final batch = _db!.batch();
    for (var json in jsonList) {
      batch.insert(_currenciesTableName, {
        'iso_code': json['iso_code'],
        'iso_numeric': json['iso_numeric'],
        'name': json['name'],
        'symbol': json['symbol'],
        'start_date': json['start_date'],
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  static Future<List<Map<String, dynamic>>> getOfflineCurrencies() async {
    return await _db!.query(_currenciesTableName);
  }

  /// Clear DataBase
  static Future<bool> clear() async {
    try {
      int count = await _db!.delete(_tableName);
      return count > 0;
    } catch (e) {
      debugPrint("Error while clearing: $e");
      throw Exception("Error while clearing database: $e");
    }
  }

  /// Close the database
  static Future<void> closeDB() async {
    if (_db != null) {
      await _db!.close();
    }
  }
}
