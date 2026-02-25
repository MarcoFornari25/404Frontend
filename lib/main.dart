import 'package:flutter/material.dart';
import 'package:frontend_404dungeon/GamePage.dart';
import 'package:frontend_404dungeon/user_pages/recover_Password.dart';
import 'user_pages/loginPage.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
  
return MaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: '/',
  routes: {
    '/': (context) => userLogin(),
    '/reset-password': (context) => Recoverpage(),
  },
);
  }
}
