import 'package:flutter/material.dart';
import 'package:jogodavelha/pages/game_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Joguim',
      theme: ThemeData(
         colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color(0xFF581485),
          secondary: Color(0xFF581485),
        ),
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
        ),
      ),
      home: const GamePage(),
    );
  }
}
