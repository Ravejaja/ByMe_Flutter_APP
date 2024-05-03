import 'package:flutter/material.dart';
import 'package:byme_flutter_app/utils/verify_user.dart';
import 'package:byme_flutter_app/utils/clear_token.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    verifyUser().then((loggedIn){
      if(loggedIn){
        
      } else {
        print('Nao esta logado');
        Navigator.of(context).pushReplacementNamed('/');
      }
    });
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            ElevatedButton(
              onPressed: () {
                clearToken();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => HomePage()),
                );
              },
              child: const Text('Limpar Token'),
            ),
            ]
          ),
        ),
      ),
    );
  }
}