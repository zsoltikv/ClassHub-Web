import 'package:classhubweb/screens/forgot_password_page.dart';
import 'package:classhubweb/screens/login_page.dart';
import 'package:classhubweb/screens/register_page.dart';
import 'package:classhubweb/theme/app_theme.dart'; // 👈 saját theme import
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ClassHub',
      debugShowCheckedModeBanner: false,

      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode
          .system,

      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPageScreen(),
        '/register': (context) => const RegisterScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
      },
    );
  }
}
