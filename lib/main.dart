import 'package:flutter/material.dart';
import 'package:sock/screen/player_entry_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bad Minton',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PlayerEntryScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}