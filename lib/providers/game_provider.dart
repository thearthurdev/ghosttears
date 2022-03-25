// import 'dart:math';
import 'dart:async';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:ghosttears/models/player.dart';

// List<String> testPlayers = [
//   'Delords',
//   'Valentine',
//   'Simon',
//   'Samuel',
//   'Audrey',
//   'Diabene',
//   'David',
//   'Oppong',
//   'Yaro',
//   'Joseph',
//   'Robert',
//   'Chris',
// ];

class GameProvider extends ChangeNotifier {
  final FocusNode _focusNode = FocusNode();
  int? _playerCount;
  int? _currentPlayer;
  int? _selectedPlayer;
  int? _penalizedPlayer;
  int? _gameOverCount;
  List<Player>? _players;
  List<String>? _usedWords;
  String? _currentWord;
  bool? _isGamePaused;
  bool? _isGameOver;
  Timer? _timer;
  int _totalTime = 10;
  double _countdownPercentage = 100;

  FocusNode get focusNode => _focusNode;
  int? get playerCount => _playerCount;
  int? get currentPlayer => _currentPlayer;
  int? get selectedPlayer => _selectedPlayer;
  int? get gameOverCount => _gameOverCount;
  List<Player>? get players => _players;
  List<String>? get usedWords => _usedWords;
  String? get currentWord => _currentWord;
  bool? get isGamePaused => _isGamePaused;
  bool? get isGameOver => _isGameOver;
  int? get totalTime => _totalTime;
  double get countdownPercentage => _countdownPercentage;

  void resetFocus() {
    _focusNode.requestFocus();
  }

  void startNewGame() {
    // _generateTestPlayers();
    resetGame();
    setCurrentPlayer(index: 0);
    setGamePausedState(state: true);
  }

  void setPlayerCount(int? count) {
    _playerCount = count;
    _generatePlayers();

    notifyListeners();
  }

  void setCountdownTime(int time) {
    _totalTime = time;

    notifyListeners();
  }

  void startTimer() {
    const tick = Duration(seconds: 1);

    int? countdownTime;

    countdownTime ??= _totalTime;

    if (isGamePaused == false) {
      _timer = Timer.periodic(tick, (timer) {
        if (countdownTime == 0) {
          forfeitTurn();
        } else {
          countdownTime = countdownTime! - 1;
          _countdownPercentage = (countdownTime! / _totalTime) * 100;

          notifyListeners();
        }
      });
    }
  }

  void cancelTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  void resetTimer() {
    cancelTimer();
    _countdownPercentage = 100.0;

    notifyListeners();
  }

  // void _generateTestPlayers() {
  //   _players = List.generate(
  //     _playerCount!,
  //     (index) => Player(
  //       playerID: index,
  //       playerName: testPlayers.elementAt(Random().nextInt(testPlayers.length)),
  //     ),
  //   );
  // }

  void _generatePlayers() {
    _players = List.generate(
      _playerCount!,
      (index) => Player(
        playerID: index,
        playerName: 'P${index + 1}',
      ),
    );
  }

  void changePlayerName(int index, String? input) {
    _players![index].playerName = input;

    if (input == '') {
      _players![index].playerName = 'P${index + 1}';
    }

    notifyListeners();
  }

  void resetGame() {
    _resetCurrentWord();
    _resetUsedWords();
    _resetPenalizedPlayer();
    _resetPlayers();
    _resetGameOverCount();
    resetTimer();
    setGamePausedState(state: true);
    setCurrentPlayer(index: 0);
    resetFocus();
  }

  void _resetPlayers() {
    for (Player player in _players!) {
      player.playerScore = 0;
    }
    // _players = [];
    // _generateTestPlayers();
  }

  void _resetPenalizedPlayer() {
    _penalizedPlayer = 0;

    notifyListeners();
  }

  void _resetCurrentWord() {
    _currentWord = null;

    notifyListeners();
  }

  void _resetUsedWords() {
    _usedWords = null;

    notifyListeners();
  }

  void setCurrentWord(String? newLetter) {
    _setPenalizedPlayer();

    if (_currentWord != null) {
      _currentWord = _currentWord! + newLetter!;
    } else {
      _currentWord = newLetter;
    }

    resetTimer();
    setGamePausedState(state: false);

    setCurrentPlayer();

    notifyListeners();
  }

  void setCurrentPlayer({int? index}) {
    if (index != null) {
      if (_players![index].isPlayerGameOver != true) {
        _currentPlayer = index;
      }
    } else {
      int nextPlayer =
          _currentPlayer! == _playerCount! - 1 ? 0 : _currentPlayer! + 1;

      if (_players![nextPlayer].isPlayerGameOver == true) {
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

  void setGamePausedState({bool? state}) {
    _isGamePaused = state ?? !_isGamePaused!;

    if (_isGamePaused == true) {
      cancelTimer();
    } else {
      startTimer();
    }

    resetFocus();

    notifyListeners();
  }

  void markCompleteWord() {
    _addToPlayerScore();
    setCurrentPlayer(index: _penalizedPlayer);
    _addToUsedWords();
    _resetCurrentWord();
    resetFocus();
    setGamePausedState(state: true);
    resetTimer();
  }

  void markWrongWord() {
    _addToPlayerScore();
    setCurrentPlayer(index: _penalizedPlayer);
    _addToUsedWords();
    _resetCurrentWord();
    resetFocus();
    setGamePausedState(state: true);
    resetTimer();
  }

  void forfeitTurn() {
    _addToPlayerScore(player: _currentPlayer);
    _addToUsedWords();
    _resetCurrentWord();
    resetFocus();
    setGamePausedState(state: true);
    resetTimer();
  }

  void _setPenalizedPlayer() {
    _penalizedPlayer = _currentPlayer;
  }

  void _addToPlayerScore({int? player}) {
    int playerToBePenalized = player ?? _penalizedPlayer!;

    int oldScore = _players!.elementAt(playerToBePenalized).playerScore!;
    int newScore = oldScore == 10 ? oldScore : oldScore + 1;

    _players!.elementAt(playerToBePenalized).playerScore = newScore;

    if (newScore == 10) {
      _players!.elementAt(playerToBePenalized).isPlayerGameOver = true;

      notifyListeners();

      _checkGameOver();
      setCurrentPlayer();
      _setPenalizedPlayer();
    }

    notifyListeners();
  }

  void _checkGameOver() {
    _gameOverCount ??= 0;
    _gameOverCount! + 1;

    _isGameOver = _gameOverCount == _playerCount! - 1;

    notifyListeners();
  }

  void _resetGameOverCount() {
    _gameOverCount = 0;
  }

  void _addToUsedWords() {
    if (_currentWord != null) {
      _usedWords ??= [];
      _usedWords!.add(_currentWord!);
    }

    notifyListeners();
  }
}


// TODO: Ability to click on a player name and perform an action on that specific player 
// TODO: Pause game on new start
// TODO: Animate countdownTimer using Animation and Tween
// TODO: Implement navigation in browser