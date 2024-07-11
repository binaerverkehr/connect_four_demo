import 'package:connect_four_demo/models/board.dart';
import 'package:connect_four_demo/models/player.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Board', () {
    late Board board;

    setUp(() {
      board = Board(rows: 6, columns: 7);
    });

    test('should initialize with empty cells', () {
      for (int row = 0; row < 6; row++) {
        for (int col = 0; col < 7; col++) {
          expect(board.getCell(row, col), equals(Player.none));
        }
      }
    });

    test('should validate moves correctly', () {
      expect(board.isValidMove(0), isTrue);
      expect(board.isValidMove(6), isTrue);
      expect(board.isValidMove(7), isFalse);
      expect(board.isValidMove(-1), isFalse);
    });

    test('should place piece at the bottom of the column', () {
      board.placePiece(3, Player.yellow);
      expect(board.getCell(5, 3), equals(Player.yellow));
      expect(board.getCell(4, 3), equals(Player.none));
    });

    test('should stack pieces in the same column', () {
      board.placePiece(3, Player.yellow);
      board.placePiece(3, Player.red);
      expect(board.getCell(5, 3), equals(Player.yellow));
      expect(board.getCell(4, 3), equals(Player.red));
      expect(board.getCell(3, 3), equals(Player.none));
    });

    test('should not allow moves in full columns', () {
      for (int i = 0; i < 6; i++) {
        expect(board.isValidMove(0), isTrue);
        board.placePiece(0, Player.yellow);
      }
      expect(board.isValidMove(0), isFalse);
    });
  });
}
