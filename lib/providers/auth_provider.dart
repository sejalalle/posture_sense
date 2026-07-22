import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool isLoading = false;

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    isLoading = true;
    notifyListeners();

    final result = await _authService.login(
      email: email,
      password: password,
    );

    isLoading = false;
    notifyListeners();

    return result;
  }

  Future<String?> register({
    required String email,
    required String password,
    String? name,
  }) async {
    isLoading = true;
    notifyListeners();

    final result = await _authService.signUp(
      email: email,
      password: password,
      name: name,
    );

    isLoading = false;
    notifyListeners();

    return result;
  }

  Future<void> logout() async {
    await _authService.logout();
  }
}