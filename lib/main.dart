import 'dart:ui_web';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'package:flutter/material.dart';
import 'package:frontend_404dungeon/game_page.dart';
import 'package:frontend_404dungeon/user_pages/recover_Password.dart';
import 'user_pages/login_page.dart';

void main() {
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        final uri = Uri.base;

        // if url shows #/reset-password it pushes you into Recover Page
        if (uri.fragment.startsWith('/reset-password')) {
          return MaterialPageRoute(builder: (_) => Recoverpage());
        }
        //otherwise it shows Login Page
        return MaterialPageRoute(builder: (_) => userLogin());
      },
    );
  }
}
