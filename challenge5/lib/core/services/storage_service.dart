import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String cartKey = 'cart_items';
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  static Future<StorageService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return StorageService(prefs);
  }

  Future<void> saveCartItems(List<Map<String, dynamic>> items) async {
    final jsonString = json.encode(items);
    await _prefs.setString(cartKey, jsonString);
  }

  Future<List<Map<String, dynamic>>> getCartItems() async {
    final jsonString = _prefs.getString(cartKey);
    if (jsonString == null) {
      return const [];
    }
    
    final jsonList = json.decode(jsonString) as List<dynamic>;
    return List<Map<String, dynamic>>.from(jsonList);
  }

  Future<void> clearCart() async {
    await _prefs.remove(cartKey);
  }
} 