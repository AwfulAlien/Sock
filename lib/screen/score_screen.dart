import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Match Over!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '$winnerName Wins!',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      child: const Text('New Match'),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _incrementPlayer1Score() {
    HapticFeedback.lightImpact();
    setState(() {
      player1Score++;
      _checkWinner();
    });
  }

  void _incrementPlayer2Score() {
    HapticFeedback.lightImpact();
    setState(() {
      player2Score++;
      _checkWinner();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: _incrementPlayer1Score,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue[200],
                  border: const Border(
                    right: BorderSide(width: 7, color: Colors.blue),
                  ),
                ),
                child: Center(
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.player1Name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '$player1Score',
                            style: const TextStyle(
                              fontSize: 72,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: _incrementPlayer2Score,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red[200],
                  border: const Border(
                    left: BorderSide(width: 7, color: Colors.red),
                  ),
                ),
                child: Center(
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.player2Name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          '$player2Score',
                          style: const TextStyle(
                            fontSize: 72,
                            fontWeight: FontWeight.w700,
                          ),
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
