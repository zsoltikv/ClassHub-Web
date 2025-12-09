import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  
  bool _rememberMe = false;
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final success = await _authService.login(
      _emailController.text,
      _passwordController.text,
      _rememberMe,
    );

    setState(() => _isLoading = false);

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hibás email vagy jelszó!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(maxWidth: 400),
            padding: EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(Icons.lock_outline, size: 80, color: Colors.blue),
                  SizedBox(height: 24),
                  Text(
                    'Bejelentkezés',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Üdvözlünk újra!',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
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
                  SizedBox(height: 16),
                  
                  // Jelszó mező
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Jelszó',
                      prefixIcon: Icon(Icons.lock_outlined),
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Kérlek add meg a jelszavad';
                      }
                      if (value.length < 6) {
                        return 'A jelszónak legalább 6 karakter hosszúnak kell lennie';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8),
                  
                  // Emlékezz rám és Elfelejtett jelszó
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (value) => setState(() => _rememberMe = value!),
                          ),
                          Text('Emlékezz rám'),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => ForgotPasswordScreen()),
                          );
                        },
                        child: Text('Elfelejtett jelszó?'),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  
                  // Bejelentkezés gomb
                  ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Bejelentkezés', style: TextStyle(fontSize: 16)),
                  ),
                  SizedBox(height: 16),
                  
                  // Regisztráció link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Még nincs fiókod?'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => RegisterScreen()),
                          );
                        },
                        child: Text('Regisztrálj'),
                      ),
                    ],
                  ),
                  
                  // Demo adatok
                  SizedBox(height: 24),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Demo fiók:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('Email: demo@example.com'),
                        Text('Jelszó: password123'),
                      ],
                    ),
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