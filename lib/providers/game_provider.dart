import 'dart:math';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:ghosttears/models/player.dart';

List<String> testPlayers = [
  'Delords',
  'Valentine',
  'Simon',
  'Samuel',
  'Audrey',
  'Diabene',
  'David',
  'Oppong',
  'Yaro',
  'Joseph',
  'Robert',
  'Chris',
];

class GameProvider extends ChangeNotifier {
  int? _playerCount;
  int? _currentPlayer;
  int? _penalizedPlayer;
  List<Player>? _players;
  List<String>? _usedWords;
  String? _currentWord;
  bool? _isGamePaused;

  int? get playerCount => _playerCount;
  int? get currentPlayer => _currentPlayer;
  List<Player>? get players => _players;
  List<String>? get usedWords => _usedWords;
  String? get currentWord => _currentWord;
  bool? get isGamePaused => _isGamePaused;

  void startNewGame() {
    setGamePaused(state: false);
    generateTestPlayers();
    resetCurrentWord();
    setCurrentPlayer(index: 0);
  }

  void setPlayerCount(int? count) {
    _playerCount = count;

    notifyListeners();
  }

  void generateTestPlayers() {
    _players = List.generate(
      _playerCount!,
      (index) => Player(
        index,
        testPlayers.elementAt(Random().nextInt(testPlayers.length)),
        0,
      ),
    );
  }

  void resetCurrentWord() {
    _currentWord = null;

    notifyListeners();
  }

  void setCurrentWord(String? newLetter) {
    if (_currentWord != null) {
      _currentWord = _currentWord! + newLetter!;
    } else {
      _currentWord = newLetter;
    }

    setCurrentPlayer();

    notifyListeners();
  }

  void setCurrentPlayer({int? index, bool? isRoundOver}) {
    if (index != null) {
      _currentPlayer = index;
    } else {
      if (isRoundOver == true ||
          currentPlayer == null ||
          _currentPlayer == _playerCount! - 1) {
        _currentPlayer = 0;
      } else {
        _currentPlayer = _currentPlayer! + 1;
      }
    }

    notifyListeners();
  }

  void setGamePaused({bool? state}) {
    if (state != null) {
      _isGamePaused = state;
    } else {
      _isGamePaused = !_isGamePaused!;
    }

    notifyListeners();
  }

  void markCompleteWord() {
    addToLastPlayerScore();
    setCurrentPlayer(index: _penalizedPlayer);
    addToUsedWords();
    resetCurrentWord();
  }

  void markWrongWord() {
    addToLastPlayerScore();
    setCurrentPlayer(index: _penalizedPlayer);
    addToUsedWords();
    resetCurrentWord();
  }

  void addToLastPlayerScore() {
    _penalizedPlayer =
        currentPlayer! == 0 ? _playerCount! - 1 : _currentPlayer! - 1;

    int oldScore = _players!.elementAt(_penalizedPlayer!).playerScore!;
    if (oldScore < 10) {
      int newScore = oldScore + 1;

      _players!.elementAt(_penalizedPlayer!).playerScore = newScore;

      if (newScore == 10) {
        _players!.elementAt(_penalizedPlayer!).isGameOver = true;
      }
    }

    notifyListeners();
  }

  void addToUsedWords() {
    _usedWords ??= [];
    _usedWords!.add(_currentWord!);
  }
}


// TODO: Ability to click on a player name and perform an action on that specific player 