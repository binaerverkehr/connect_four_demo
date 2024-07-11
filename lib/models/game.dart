import 'package:connect_four_demo/models/board.dart';
import 'package:connect_four_demo/models/player.dart';

class Game {
  /*
  Represents the game state.
  */

  final Board board;
  Player currentPlayer;
  Player? winner;
  bool isDraw;
  int moveCount;

  Game({required this.board})
      : currentPlayer = Player.yellow,
        winner = null,
        isDraw = false,
        moveCount = 0;

  bool makeMove(int column) {
    """
    Places a piece in the given column if it is a valid move.
    """;
    if (!board.isValidMove(column) || winner != null) return false;

    int row = -1;
    for (int r = board.rows - 1; r >= 0; r--) {
      if (board.getCell(r, column) == Player.none) {
        board.placePiece(column, currentPlayer);
        row = r;
        break;
      }
    }

    if (row == -1) return false;

    moveCount++;

    if (checkWin(row, column)) {
      winner = currentPlayer;
    } else if (moveCount == board.rows * board.columns) {
      isDraw = true;
    } else {
      currentPlayer =
          currentPlayer == Player.yellow ? Player.red : Player.yellow;
    }

    return true;
  }

  bool checkWin(int row, int column) {
    """
    Checks if the last move resulted in a win.
    """;
    return checkDirection(row, column, 1, 0) || // Vertical
        checkDirection(row, column, 0, 1) || // Horizontal
        checkDirection(row, column, 1, 1) || // Diagonal (/)
        checkDirection(row, column, 1, -1); // Diagonal (\)
  }

  bool checkDirection(int row, int col, int rowDelta, int colDelta) {
    """
    Checks if there are four pieces in a row in the given direction.
    """;
    Player player = board.getCell(row, col);
    int count = 1;

    // Check in positive direction
    for (int i = 1; i < 4; i++) {
      int newRow = row + i * rowDelta;
      int newCol = col + i * colDelta;
      if (newRow < 0 ||
          newRow >= board.rows ||
          newCol < 0 ||
          newCol >= board.columns) break;
      if (board.getCell(newRow, newCol) != player) break;
      count++;
    }

    // Check in negative direction
    for (int i = 1; i < 4; i++) {
      int newRow = row - i * rowDelta;
      int newCol = col - i * colDelta;
      if (newRow < 0 ||
          newRow >= board.rows ||
          newCol < 0 ||
          newCol >= board.columns) break;
      if (board.getCell(newRow, newCol) != player) break;
      count++;
    }

    return count >= 4;
  }
}
