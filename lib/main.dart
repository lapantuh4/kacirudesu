import 'package:flutter/material.dart';
import 'package:kaciru_desu/pages/home_page.dart';
import 'package:kaciru_desu/pages/login_page.dart';
import 'package:kaciru_desu/pages/register_page.dart';
import 'package:kaciru_desu/themes/dark_mode.dart';
import 'package:kaciru_desu/themes/light_mode.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegisterPage(),
      theme: lightMode,
      darkTheme: darkMode,
      debugShowCheckedModeBanner: false,
    );
  }
}
