import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class Userprovider extends ChangeNotifier {
  Future<String> checkToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  Future<void> setToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    try {
      final response = await Dio().get(
        'https://www.pqstec.com/InvoiceApps/Values/login?UserName=$email&Password=$password&ComId=1',
      );

      final data = response.data;
      if (data['Token'] != null) {
        await setToken(data['Token']);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
