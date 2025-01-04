import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScoreScreen extends StatefulWidget {
  final String player1Name;
  final String player2Name;
  final int? maxScore;

  const ScoreScreen({
    super.key,
    required this.player1Name,
    required this.player2Name,
    required this.maxScore,
  });

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  int player1Score = 0;
  int player2Score = 0;

  void _checkWinner() {
    if (player1Score >= widget.maxScore!) {
      _showWinnerDialog(widget.player1Name);
    } else if (player2Score >= widget.maxScore!) {
      _showWinnerDialog(widget.player2Name);
    }
  }

  void _showWinnerDialog(String winnerName) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return RotatedBox(
            quarterTurns: 1,
            child: AlertDialog(
              title: Text('Match Over!'),
              content: Text('$winnerName Wins!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text('New Match'),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  player1Score++;
                  _checkWinner();
                });
              },
              child: Container(
                color: Colors.blue[200],
                child: Center(
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.player1Name,
                          style: const TextStyle(fontSize: 20),
                        ),
                        Text(
                          '$player1Score',
                          style: const TextStyle(fontSize: 48),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  player2Score++;
                  _checkWinner();
                });
              },
              child: Container(
                color: Colors.red[200],
                child: Center(
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.player2Name,
                          style: const TextStyle(fontSize: 20),
                        ),
                        Text(
                          '$player2Score',
                          style: const TextStyle(fontSize: 48),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
