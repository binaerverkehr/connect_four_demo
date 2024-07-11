import 'package:connect_four_demo/models/player.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Player enum should have three values: none, yellow, and red', () {
    expect(Player.values.length, 3);
    expect(Player.values, contains(Player.none));
    expect(Player.values, contains(Player.yellow));
    expect(Player.values, contains(Player.red));
  });
}
