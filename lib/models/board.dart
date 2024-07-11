/*
Board class for a Connect Four game.
*/

import 'package:connect_four_demo/models/player.dart';

class Board {
  /*
  Represents the game board.
  */

  final int rows;
  final int columns;
  late List<List<Player>> grid;

  Board({required this.rows, required this.columns}) {
    """
    Initializes the board with the given number of rows and columns.
    """;
    grid = List.generate(rows, (_) => List.filled(columns, Player.none));
  }

  Player getCell(int row, int col) => grid[row][col];

  bool isValidMove(int col) {
    """
    Returns true if the column is within the board and the column is not full.
    """;
    return col >= 0 && col < columns && grid[0][col] == Player.none;
  }

  void placePiece(int col, Player player) {
    """
    Places a piece in the column if it is a valid move.
    """;
    if (!isValidMove(col)) return;

    for (int row = rows - 1; row >= 0; row--) {
      if (grid[row][col] == Player.none) {
        grid[row][col] = player;
        break;
      }
    }
  }
}
