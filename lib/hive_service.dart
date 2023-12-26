import 'dart:async';

import 'package:hive_flutter/adapters.dart';
import 'package:hive_test/person.dart';

abstract class LocalStorage<T> {
  Future<bool> initHive();
  Box getBox();
  Future<void> addToBoxWithKey(dynamic key, T item);
  T? getItem(dynamic key);
  Future<void> removeItem(dynamic key);
  Future<void> clearBox();
  Future<void> closeBox();
  Future<void> openBox();
  Future<void> updateItem(key, value);
}

class HiveStorage<T> implements LocalStorage<T> {
  late Box _box;

  @override
  Future<bool> initHive() async {
    await Hive.initFlutter();
    return true;
  }

  @override
  Future<void> openBox() async {
    Hive.registerAdapter(PersonAdapter());
    _box = await Hive.openBox('myBox');
  }

  @override
  Future<void> addToBoxWithKey(key, item) async {
    await _box.put(key, item);
  }

  @override
  Future<void> clearBox() async {
    await _box.clear();
  }

  @override
  Future<void> closeBox() async {
    await _box.close();
  }

  @override
  Box getBox() {
    return _box;
  }

  @override
  getItem(key) {
    return _box.get(key);
  }

  @override
  Future<void> removeItem(key) async {
    await _box.delete(key);
  }

  @override
  Future<void> updateItem(key, value) async {
    await _box.putAt(key, value);
  }
}
