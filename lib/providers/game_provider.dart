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
  final FocusNode _focusNode = FocusNode();

  int? get playerCount => _playerCount;
  int? get currentPlayer => _currentPlayer;
  List<Player>? get players => _players;
  List<String>? get usedWords => _usedWords;
  String? get currentWord => _currentWord;
  bool? get isGamePaused => _isGamePaused;
  FocusNode get focusNode => _focusNode;

  void resetFocus() {
    _focusNode.requestFocus();
  }

  void startNewGame() {
    setGamePaused(state: false);
    generateTestPlayers();
    resetGame();
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
        playerID: index,
        playerName: testPlayers.elementAt(Random().nextInt(testPlayers.length)),
      ),
    );
  }

  void resetGame() {
    resetCurrentWord();
    resetUsedWords();
    resetPenalizedPlayer();
    resetPlayers();
    setCurrentPlayer(index: 0);
    resetFocus();
  }

  void resetPlayers() {
    _players = [];
    generateTestPlayers();
  }

  void resetPenalizedPlayer() {
    _penalizedPlayer = 0;

    notifyListeners();
  }

  void resetCurrentWord() {
    _currentWord = null;

    notifyListeners();
  }

  void resetUsedWords() {
    _usedWords = null;

    notifyListeners();
  }

  void setCurrentWord(String? newLetter) {
    setPenalizedPlayer();

    if (_currentWord != null) {
      _currentWord = _currentWord! + newLetter!;
    } else {
      _currentWord = newLetter;
    }

    setCurrentPlayer();

    notifyListeners();
  }

  void setCurrentPlayer({int? index}) {
    if (index != null) {
      if (_players![index].isGameOver != true) {
        _currentPlayer = index;
      }
    } else {
      int nextPlayer =
          _currentPlayer! == _playerCount! - 1 ? 0 : _currentPlayer! + 1;

      if (_players![nextPlayer].isGameOver == true) {
        _currentPlayer = nextPlayer;
        setCurrentPlayer();
      } else {
        if (_currentPlayer == null) {
          _currentPlayer = 0;
        } else {
          _currentPlayer = nextPlayer;
        }
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
    addToPenalizedPlayerScore();
    setCurrentPlayer(index: _penalizedPlayer);
    addToUsedWords();
    resetCurrentWord();
    resetFocus();
  }

  void markWrongWord() {
    addToPenalizedPlayerScore();
    setCurrentPlayer(index: _penalizedPlayer);
    // addToUsedWords();
    resetCurrentWord();
    resetFocus();
  }

  void setPenalizedPlayer() {
    _penalizedPlayer = _currentPlayer;
  }

  void addToPenalizedPlayerScore() {
    int oldScore = _players!.elementAt(_penalizedPlayer!).playerScore!;
    int newScore = oldScore == 10 ? oldScore : oldScore + 1;

    _players!.elementAt(_penalizedPlayer!).playerScore = newScore;

    if (newScore == 10) {
      _players!.elementAt(_penalizedPlayer!).isGameOver = true;

      notifyListeners();
      
      setCurrentPlayer();
      setPenalizedPlayer();
    }

    notifyListeners();
  }

  void addToUsedWords() {
    if (_currentWord != null) {
      _usedWords ??= [];
      _usedWords!.add(_currentWord!);
    }

    notifyListeners();
  }
}


// TODO: Ability to click on a player name and perform an action on that specific player 
// TODO: Pause game on new start