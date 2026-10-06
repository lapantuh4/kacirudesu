import 'package:flutter/material.dart';
import 'package:kaciru_desu/pages/foods_page.dart';
import 'package:kaciru_desu/pages/histori_page.dart';
import 'package:kaciru_desu/pages/home_page.dart';
import 'package:kaciru_desu/pages/kasir_page.dart';
import 'package:kaciru_desu/pages/login_page.dart';
import 'package:kaciru_desu/pages/profile_page.dart';
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
      home: HomePage(),
      theme: lightMode,
      darkTheme: darkMode,
      debugShowCheckedModeBanner: false,
      routes: {
        '/profile': (context) => ProfilePage(),
        '/kasir': (context) => KasirPage(),
        '/histori': (context) => HistoriPage(),
        '/foods': (context) => FoodsPage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
