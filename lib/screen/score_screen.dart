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
  @override
  void initState() {
    super.initState();
    // Set landscape orientation for this screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    // Reset to portrait when leaving this screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  int player1Score = 0;
  int player2Score = 0;
  List<List<int>> scoreHistory = [];
  bool isButtonDisabled = true;

  void _checkWinner() {
    if (player1Score >= widget.maxScore! &&
        (player1Score - player2Score >= 2)) {
      _showWinnerDialog(widget.player1Name);
    } else if (player2Score >= widget.maxScore! &&
        (player2Score - player1Score >= 2)) {
      _showWinnerDialog(widget.player2Name);
    }
  }

  void _showWinnerDialog(String winnerName) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
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
          );
        });
  }

  void _incrementPlayer1Score() {
    HapticFeedback.lightImpact();
    setState(() {
      player1Score++;
      isButtonDisabled = false;
      _saveScoreToHistory();
      _checkWinner();
    });
  }

  void _incrementPlayer2Score() {
    HapticFeedback.lightImpact();
    setState(() {
      player2Score++;
      isButtonDisabled = false;
      _saveScoreToHistory();
      _checkWinner();
    });
  }

  void _saveScoreToHistory() {
    scoreHistory.add([player1Score, player2Score]);
  }

  void _undoLastScore() {
    if (scoreHistory.length > 1) {
      HapticFeedback.heavyImpact();
      scoreHistory.removeLast();
      List<int> previousScore = scoreHistory.last;
      setState(() {
        player1Score = previousScore[0];
        player2Score = previousScore[1];
      });
    } else if (scoreHistory.length == 1) {
      _resetScore();
    }
  }

  void _resetScore() {
    HapticFeedback.heavyImpact();
    setState(() {
      scoreHistory.clear();
      player1Score = 0;
      player2Score = 0;
      isButtonDisabled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: _incrementPlayer1Score,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[200],
                    border: const Border(
                      top: BorderSide(width: 7, color: Colors.blue),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.player1Name,
                            style: const TextStyle(
                              fontSize: 32,
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
            Expanded(
              child: GestureDetector(
                onTap: _incrementPlayer2Score,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red[200],
                    border: const Border(
                      bottom: BorderSide(width: 7, color: Colors.red),
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.player2Name,
                          style: const TextStyle(
                            fontSize: 32,
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
          ],
        ),
        Align(
          alignment: const Alignment(0, -0.9),
          child: FloatingActionButton(
            onPressed: isButtonDisabled ? null : _undoLastScore,
            child:
                Icon(Icons.undo, color: isButtonDisabled ? Colors.grey : null),
          ),
        ),
        Align(
          alignment: const Alignment(0, -0.4),
          child: FloatingActionButton(
            mini: true,
            onPressed: isButtonDisabled ? null : _resetScore,
            child: Icon(Icons.settings_backup_restore,
                color: isButtonDisabled ? Colors.grey : null),
          ),
        ),
      ]),
    );
  }
}
