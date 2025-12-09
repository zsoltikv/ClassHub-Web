import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Map<String, String> _users = {
    'demo@example.com': 'password123',
  };

  Future<bool> login(String email, String password, bool rememberMe) async {
    await Future.delayed(Duration(seconds: 1)); // Szimulált hálózati késleltetés
    
    if (_users[email] == password) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_email', email);
      await prefs.setBool('remember_me', rememberMe);
      return true;
    }
    return false;
  }

  Future<bool> register(String email, String password) async {
    await Future.delayed(Duration(seconds: 1));
    
    if (_users.containsKey(email)) {
      return false;
    }
    
    _users[email] = password;
    return true;
  }

  Future<bool> resetPassword(String email) async {
    await Future.delayed(Duration(seconds: 1));
    return _users.containsKey(email);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_email');
    await prefs.setBool('remember_me', false);
  }

  Future<String?> getLoggedInUser() async {
    final prefs = await SharedPreferences.getInstance();
    final rememberMe = prefs.getBool('remember_me') ?? false;
    if (rememberMe) {
      return prefs.getString('user_email');
    }
    return null;
  }
}