import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VelmoraStore extends ChangeNotifier {
  List<dynamic> stretches = [];

  Future<void> load(String jsonStr) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('velmora_stretches')) {
      stretches = jsonDecode(jsonStr)['stretches'] ?? [];
      await save();
    } else {
      stretches = jsonDecode(prefs.getString('velmora_stretches')!);
    }
    notifyListeners();
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('velmora_stretches', jsonEncode(stretches));
  }
}
