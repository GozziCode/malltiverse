import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/cart_model.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'cart.db');
    
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cart (
        id TEXT PRIMARY KEY,
        cartImage TEXT,
        name TEXT,
        description TEXT,
        price REAL,
        quantity INTEGER
      )
    ''');
  }

  Future<void> insertCartItem(CartItem cartItem) async {
    final db = await database;
     debugPrint('Inserting cart item: ${cartItem.toMap()}'); 
    await db.insert('cart', cartItem.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<CartItem>> getCartItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('cart');
     debugPrint('Retrieved cart items: $maps');
    if (maps.isEmpty) {
      return [];
    }

    return List<CartItem>.generate(maps.length, (i) {
      return CartItem.fromMap(maps[i]);
    });
  }

  Future<void> updateCartItem(CartItem cartItem) async {
    final db = await database;
    await db.update('cart', cartItem.toMap(), where: 'id = ?', whereArgs: [cartItem.id]);
  }

  Future<void> deleteCartItem(String id) async {
    final db = await database;
    await db.delete('cart', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearCart() async {
    final db = await database;
    await db.delete('cart');
  }
}
