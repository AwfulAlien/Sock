import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sock/screen/score_screen.dart';

class PlayerEntryScreen extends StatefulWidget {
  const PlayerEntryScreen({super.key});

  @override
  State<PlayerEntryScreen> createState() => _PlayerEntryScreenState();
}

class _PlayerEntryScreenState extends State<PlayerEntryScreen> {
  final _player1Controller = TextEditingController();
  final _player2Controller = TextEditingController();

  void _startMatch() {
    if (_player1Controller.text.isEmpty && _player2Controller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please Enter both player names'),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScoreScreen(
            player1Name: _player1Controller.text,
            player2Name: _player2Controller.text,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Player Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _player1Controller,
              decoration: const InputDecoration(labelText: 'Player 1 Name'),
            ),
            TextField(
              controller: _player2Controller,
              decoration: const InputDecoration(labelText: 'Player 2 Name'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: _startMatch,
              child: const Text('Start Match'),
            ),
          ],
        ),
      ),
    );
  }
}
