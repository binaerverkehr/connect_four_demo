import 'package:connect_four_demo/models/board.dart';
import 'package:connect_four_demo/models/game.dart';
import 'package:connect_four_demo/models/player.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late Game _game;

  @override
  void initState() {
    super.initState();
    _resetGame();
  }

  void _resetGame() {
    setState(() {
      _game = Game(board: Board(rows: 6, columns: 7));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildGameStatus(),
              const SizedBox(height: 30),
              Expanded(
                child: _buildGameBoard(),
              ),
              const SizedBox(height: 80),
              _buildResetButton(),
            ],
          ),
        ),
      ),
    );
  }

  GridView _buildGameBoard() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _game.board.rows * _game.board.columns,
      itemBuilder: (context, index) {
        int row = index ~/ _game.board.columns;
        int col = index % _game.board.columns;
        return GestureDetector(
          onTap: () {
            if (_game.winner == null && !_game.isDraw) {
              setState(() {
                _game.makeMove(col);
              });
            }
          },
          child: _buildBoardCell(row, col),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _game.board.columns,
      ),
    );
  }

  Widget _buildBoardCell(int row, int col) {
    /*
    Builds a single cell of the game board.
    */

    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _game.board.getCell(row, col) == Player.yellow
            ? Colors.yellow
            : _game.board.getCell(row, col) == Player.red
                ? Colors.red
                : Colors.white,
        border: Border.all(color: Colors.black),
      ),
    );
  }

  Widget _buildGameStatus() {
    /*
    Builds the game status widget.
    */

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (_game.winner == null && !_game.isDraw)
          Row(
            children: [
              const Text('Current Player: ', style: TextStyle(fontSize: 18)),
              _buildPlayerToken(_game.winner ?? _game.currentPlayer),
            ],
          ),
        if (_game.winner != null)
          Row(
            children: [
              _buildPlayerToken(_game.winner ?? _game.currentPlayer),
              const SizedBox(width: 10),
              const Text(
                'wins! ',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        if (_game.isDraw)
          const Text(
            'It\'s a draw!',
            style: TextStyle(fontSize: 18),
          ),
      ],
    );
  }

  Container _buildPlayerToken(Player player) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: player == Player.yellow ? Colors.yellow : Colors.red,
        border: Border.all(color: Colors.black),
      ),
    );
  }

  Widget _buildResetButton() {
    /*
    Builds the reset button widget.
    */

    return TextButton.icon(
      icon: const Icon(Icons.refresh),
      label: Text(
        _game.winner != null || _game.isDraw ? 'New Game' : 'Reset Game',
      ),
      onPressed: _resetGame,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
      ),
    );
  }
}
