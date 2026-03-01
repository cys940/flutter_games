import 'package:flutter/material.dart';

class PuzzleGameScreen extends StatelessWidget {
  const PuzzleGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Puzzle Game')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the Puzzle Game!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement game logic or navigate to game
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Starting a new puzzle!')),
                );
              },
              child: const Text('Start Puzzle'),
            ),
          ],
        ),
      ),
    );
  }
}
