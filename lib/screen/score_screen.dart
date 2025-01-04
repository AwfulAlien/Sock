import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScoreScreen extends StatefulWidget {
  final String player1Name;
  final String player2Name;

  const ScoreScreen(
      {super.key, required this.player1Name, required this.player2Name});

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  int player1Score = 0;
  int player2Score = 0;

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
