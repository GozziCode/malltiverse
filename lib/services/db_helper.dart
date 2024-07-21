import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/cart_model.dart';
import '../models/order_model.dart';

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
      version: 2,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
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
        totalAmount REAL
      )
    ''');

    await db.execute('''
      CREATE TABLE orders (
        id TEXT PRIMARY KEY,
        items TEXT,
        totalAmount REAL,
        dateTime TEXT,
        address TEXT,
        contactDetails TEXT,
        paymentConfirmed INTEGER
      )
    ''');
  }
  
Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE orders (
          id TEXT PRIMARY KEY,
          items TEXT,
          totalAmount REAL,
          dateTime TEXT,
          address TEXT,
          contactDetails TEXT,
          paymentConfirmed INTEGER
        )
      ''');
    }
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

  //Methods for orders 
 Future<void> insertOrder(Order order) async {
    final db = await database;
    await db.insert('orders', order.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

   Future<List<Order>> getOrderHistory() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('orders');
    return List.generate(maps.length, (i) {
      return Order.fromMap(maps[i]);
    });
  }
Future<void> deleteOrder(String id) async {
    final db = await database;
    await db.delete('orders', where: 'id = ?', whereArgs: [id]);
  }
  
}
