import 'package:byme_flutter_app/pages/auth/landing_page.dart';
import 'package:byme_flutter_app/pages/auth/register_page.dart';
import 'package:byme_flutter_app/pages/auth/login_page.dart';
import 'package:byme_flutter_app/pages/auth/forgot_pass_page.dart';
import 'package:byme_flutter_app/pages/navigation/inside_app.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ByMe',
      theme: ThemeData(
        fontFamily: 'Lato',
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingPage(),
        '/register': (context) => const RegisterPage(),
        '/login': (context) => const LoginPage(),
        '/forgot_password': (context) => const ForgotPasswordPage(),
        '/inside_app': (context) => const InsideApp(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
