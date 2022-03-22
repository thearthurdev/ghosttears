import 'dart:math';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:ghosttears/models/player.dart';

List<String> testPlayers = [
  'Delords',
  'Valentine',
  'Simon',
  'Samuel',
  'Diabene',
  'David',
  'Oppong',
  'Yaro',
  'Joseph',
];

class GameProvider extends ChangeNotifier {
  int? _playerCount;
  late List<Player> _players;

  int? get playerCount => _playerCount;

  List<Player>? get players => _players;

  void setPlayerCount(int? count) {
    _playerCount = count;
    notifyListeners();
  }

  void startGame() {
    _players = List.generate(
      _playerCount!,
      (index) => Player(
        index,
        testPlayers.elementAt(Random().nextInt(testPlayers.length)),
        0,
      ),
    );
  }
}
