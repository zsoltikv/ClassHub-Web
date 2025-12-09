import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _authService = AuthService();
  
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final success = await _authService.resetPassword(_emailController.text);

    setState(() => _isLoading = false);

    if (success) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Email elküldve'),
          content: Text(
            'Jelszó-visszaállító linket küldtünk a(z) ${_emailController.text} címre. '
            'Kérlek ellenőrizd a postafiókodat!',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nem találtuk ezt az email címet!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Elfelejtett jelszó')),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(maxWidth: 400),
            padding: EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(Icons.help_outline, size: 80, color: Colors.blue),
                  SizedBox(height: 24),
                  Text(
                    'Jelszó visszaállítása',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Add meg az email címed és küldünk egy visszaállító linket',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32),
                  
                  // Email mező
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email cím',
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Kérlek add meg az email címed';
                      }
                      if (!value.contains('@')) {
                        return 'Érvénytelen email cím';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 32),
                  
                  // Visszaállítás gomb
                  ElevatedButton(
                    onPressed: _isLoading ? null : _resetPassword,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Visszaállító link küldése', style: TextStyle(fontSize: 16)),
                  ),
                  SizedBox(height: 16),
                  
                  // Vissza a bejelentkezéshez
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Vissza a bejelentkezéshez'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}