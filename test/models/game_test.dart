/*
Tests for the game class.
 */

import 'package:connect_four_demo/models/board.dart';
import 'package:connect_four_demo/models/game.dart';
import 'package:connect_four_demo/models/player.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Game', () {
    late Game game;

    setUp(() {
      game = Game(board: Board(rows: 6, columns: 7));
    });

    test('should start with yellow player', () {
      expect(game.currentPlayer, equals(Player.yellow));
    });

    test('should switch players after a move', () {
      game.makeMove(0);
      expect(game.currentPlayer, equals(Player.red));
    });

    test('should detect a horizontal win', () {
      game.makeMove(0); // Yellow
      game.makeMove(0); // Red
      game.makeMove(1); // Yellow
      game.makeMove(1); // Red
      game.makeMove(2); // Yellow
      game.makeMove(2); // Red
      game.makeMove(3); // Yellow
      expect(game.winner, equals(Player.yellow));
    });

    test('should detect a vertical win', () {
      game.makeMove(0); // Yellow
      game.makeMove(1); // Red
      game.makeMove(0); // Yellow
      game.makeMove(1); // Red
      game.makeMove(0); // Yellow
      game.makeMove(1); // Red
      game.makeMove(0); // Yellow
      expect(game.winner, equals(Player.yellow));
    });

    test('should detect a diagonal win (bottom-left to top-right)', () {
      game.makeMove(0); // Yellow
      game.makeMove(1); // Red
      game.makeMove(1); // Yellow
      game.makeMove(2); // Red
      game.makeMove(2); // Yellow
      game.makeMove(3); // Red
      game.makeMove(2); // Yellow
      game.makeMove(3); // Red
      game.makeMove(3); // Yellow
      game.makeMove(6); // Red
      game.makeMove(3); // Yellow
      expect(game.winner, equals(Player.yellow));
    });

    test('should detect a diagonal win (top-left to bottom-right)', () {
      game.makeMove(4); // Yellow
      game.makeMove(3); // Red
      game.makeMove(3); // Yellow
      game.makeMove(2); // Red
      game.makeMove(2); // Yellow
      game.makeMove(6); // Red
      game.makeMove(2); // Yellow
      game.makeMove(1); // Red
      game.makeMove(1); // Yellow
      game.makeMove(1); // Red
      game.makeMove(1); // Yellow

      expect(game.winner, equals(Player.yellow));
    });

    test('should detect a draw', () {
      List<int> moves = [
        0,
        1,
        0,
        1,
        0,
        1,
        1,
        0,
        1,
        0,
        1,
        0,
        2,
        3,
        2,
        3,
        2,
        3,
        3,
        2,
        3,
        2,
        3,
        2,
        4,
        5,
        4,
        5,
        4,
        5,
        5,
        4,
        5,
        4,
        5,
        4,
        6,
        6,
        6,
        6,
        6,
        6,
      ];

      for (int move in moves) {
        game.makeMove(move);
      }

      expect(game.winner, isNull);
      expect(game.isDraw, isTrue);
    });
  });
}
