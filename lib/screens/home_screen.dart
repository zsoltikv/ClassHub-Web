import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  final _authService = AuthService();

  Future<void> _logout(BuildContext context) async {
    await _authService.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kezdőlap'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context),
            tooltip: 'Kijelentkezés',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_outline, size: 100, color: Colors.green),
            SizedBox(height: 24),
            Text(
              'Sikeres bejelentkezés!',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Üdvözlünk az alkalmazásban',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 48),
            ElevatedButton.icon(
              onPressed: () => _logout(context),
              icon: Icon(Icons.logout),
              label: Text('Kijelentkezés'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}