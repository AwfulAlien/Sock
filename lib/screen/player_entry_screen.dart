import 'package:flutter/material.dart';
import 'package:sock/screen/match_history_screen.dart';
import 'package:sock/screen/score_screen.dart';

class PlayerEntryScreen extends StatefulWidget {
  const PlayerEntryScreen({super.key});

  @override
  State<PlayerEntryScreen> createState() => _PlayerEntryScreenState();
}

class _PlayerEntryScreenState extends State<PlayerEntryScreen> {
  final _player1Controller = TextEditingController();
  final _player2Controller = TextEditingController();
  int? _maxScore;

  void _startMatch() {
    if (_player1Controller.text.trim().isEmpty ||
        _player2Controller.text.trim().isEmpty ||
        _maxScore == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter both player names and score'),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScoreScreen(
            player1Name: _player1Controller.text.trim(),
            player2Name: _player2Controller.text.trim(),
            maxScore: _maxScore,
          ),
        ),
      );
    }
  }

  void _swapPlayerNames() {
    setState(() {
      final temp = _player1Controller.text;
      _player1Controller.text = _player2Controller.text;
      _player2Controller.text = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Player Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _player1Controller,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Player 1 Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              IconButton(
                onPressed: _swapPlayerNames,
                icon: const Icon(Icons.swap_vert),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _player2Controller,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Player 2 Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 180,
                child: DropdownButtonFormField<int>(
                    decoration: const InputDecoration(
                      labelText: 'Max Score',
                      border: OutlineInputBorder(),
                    ),
                    value: _maxScore,
                    items: const [
                      DropdownMenuItem(
                        value: 11,
                        child: Text('11'),
                      ),
                      DropdownMenuItem(
                        value: 21,
                        child: Text('21'),
                      ),
                    ],
                    isExpanded: true,
                    onChanged: (int? newValue) {
                      setState(() {
                        _maxScore = newValue;
                      });
                    }),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _startMatch,
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 18),
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white),
                child: const Text('Start Match'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
