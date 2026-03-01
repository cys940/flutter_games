import 'package:flutter/material.dart';

class GameDetailPage extends StatelessWidget {
  const GameDetailPage({super.key, required this.gameId});

  final String gameId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Game Detail: $gameId')),
      body: Center(child: Text('Details for Game ID: $gameId')),
    );
  }
}
