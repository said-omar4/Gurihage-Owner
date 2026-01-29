// lib/core/providers/auth_provider.dart
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  String? _token;
  Map<String, dynamic>? _user;

  bool get isAuthenticated => _isAuthenticated;
  String? get token => _token;
  Map<String, dynamic>? get user => _user;

  Future<void> login(String email, String password) async {
    // API call here
    _isAuthenticated = true;
    _token = 'sample_token';
    notifyListeners();
  }

  Future<void> logout() async {
    _isAuthenticated = false;
    _token = null;
    _user = null;
    notifyListeners();
  }
}
