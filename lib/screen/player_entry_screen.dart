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
  final _maxScoreController = TextEditingController();

  void _startMatch() {
    if (_player1Controller.text.isEmpty &&
        _player2Controller.text.isEmpty &&
        _maxScoreController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please Enter both player names and Score'),
        ),
      );
    } else {
      int? maxScore = int.tryParse(_maxScoreController.text);
      if (maxScore == null || maxScore <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text('Please enter a valid positive number for Max Score')),
        );
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScoreScreen(
            player1Name: _player1Controller.text,
            player2Name: _player2Controller.text,
            maxScore: maxScore,
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
              TextField(
                controller: _maxScoreController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Max Score',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 32),
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
