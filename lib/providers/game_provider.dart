import 'dart:async';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:ghosttears/models/player.dart';

typedef GameEvent = Function();

class GameProvider extends ChangeNotifier {
  final FocusNode _nextLetterTextFieldFocusNode = FocusNode();
  final TextEditingController _nextLetterTextFieldController =
      TextEditingController();

  FocusNode get nextLetterTextFieldFocusNode => _nextLetterTextFieldFocusNode;
  TextEditingController get nextLetterTextFieldController =>
      _nextLetterTextFieldController;

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
  int _totalTime = 15;
  int? _countdownTime;
  double _countdownPercentage = 100;
  List<String>? _gameHistory;

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
  List<String>? get gameHistory => _gameHistory;

  Map<String, GameEvent> _redoUndoMap() {
    return {
      'markCompleteWord': undoMarkCompleteWord,
      'markWrongWord': undoMarkWrongWord,
      'forfeitTurn': undoForfeitTurn,
    };
  }

  void resetFocus() {
    WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) => _nextLetterTextFieldFocusNode.requestFocus());
  }

  void resetTextField() {
    WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) => _nextLetterTextFieldController.clear());
  }

  void startNewGame() {
    resetGame();
    setCurrentPlayer(index: 0);
    setGamePausedState(state: true);
  }

  void setPlayerCount(int? count) {
    _playerCount = count;
    _generatePlayers();

    notifyListeners();
  }

  void setTotalTime(int time) {
    _totalTime = time;

    notifyListeners();
  }

  void startTimer() {
    const tick = Duration(seconds: 1);

    _countdownTime ??= _totalTime;

    if (isGamePaused == false) {
      _timer = Timer.periodic(tick, (timer) {
        if (_countdownTime == 0) {
          forfeitTurn();
        } else {
          _countdownTime = _countdownTime! - 1;
          _countdownPercentage = (_countdownTime! / _totalTime) * 100;

          notifyListeners();
        }
      });
    }
  }

  void cancelTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _countdownTime = null;
    }
  }

  void resetTimer() {
    cancelTimer();
    _countdownPercentage = 100.0;

    notifyListeners();
  }

  void _generatePlayers() {
    _players = List.generate(
      _playerCount!,
      (index) => Player(
        playerIndex: index,
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
    _resetGameHistory();
    _resetPenalizedPlayer();
    _resetPlayers();
    _resetGameOverCount();
    resetTimer();
    setGamePausedState(state: true);
    setCurrentPlayer(index: 0);
    resetFocus();
    resetTextField();
  }

  void _resetPlayers() {
    if (_players != null) {
      for (Player player in _players!) {
        player.playerScore = 0;
        player.isPlayerGameOver = false;
      }
    }
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

  void setCurrentWord({String? newLetter}) {
    if (newLetter != null) {
      _setPenalizedPlayer();

      if (_currentWord != null) {
        _currentWord = _currentWord! + newLetter;
      } else {
        _currentWord = newLetter;
      }

      resetTimer();
      setGamePausedState(state: false);

      setCurrentPlayer();
    }

    notifyListeners();
  }

  void undoSetCurrentWord() {
    if (_currentWord != null) {
      if (_currentWord!.length > 1) {
        _currentWord = _currentWord!.substring(0, _currentWord!.length - 1);
      } else {
        _currentWord = null;
      }
    }

    notifyListeners();
  }

  void setCurrentPlayer({int? index}) {
    if (index != null) {
      if (_players![index].isPlayerGameOver != true) {
        _currentPlayer = index;
      }
    } else {
      int previousPlayer =
          _currentPlayer! == _playerCount! - 1 ? 0 : _currentPlayer! + 1;

      if (_players![previousPlayer].isPlayerGameOver == true) {
        _currentPlayer = previousPlayer;
        setCurrentPlayer();
      } else {
        if (_currentPlayer == null) {
          _currentPlayer = 0;
        } else {
          _currentPlayer = previousPlayer;
        }
      }
    }

    notifyListeners();
  }

  void undoSetCurrentPlayer() {
    int previousPlayer =
        _currentPlayer! == 0 ? _playerCount! - 1 : _currentPlayer! - 1;

    if (_players![previousPlayer].isPlayerGameOver == true) {
      _currentPlayer = previousPlayer;
      undoSetCurrentPlayer();
    } else {
      if (_currentPlayer == null) {
        _currentPlayer = 0;
      } else {
        _currentPlayer = previousPlayer;
      }
    }

    notifyListeners();
  }

  void toggleSelectedPlayer(int player) {
    if (_selectedPlayer == null) {
      _selectedPlayer = player;
    } else {
      _selectedPlayer = null;
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

    _addToGameHistory('markCompleteWord');
  }

  void undoMarkCompleteWord() {
    _undoAddToPlayerScore();
    _undoAddToUsedWords();
  }

  void markWrongWord() {
    _addToPlayerScore();
    setCurrentPlayer(index: _penalizedPlayer);
    _addToUsedWords();
    _resetCurrentWord();
    resetFocus();
    setGamePausedState(state: true);
    resetTimer();

    _addToGameHistory('markWrongWord');
  }

  void undoMarkWrongWord() {
    _undoAddToPlayerScore();
    _undoAddToUsedWords();
  }

  void forfeitTurn() {
    _addToPlayerScore(player: _currentPlayer);
    _addToUsedWords();
    _resetCurrentWord();
    resetFocus();
    setGamePausedState(state: true);
    resetTimer();

    _addToGameHistory('forfeitTurn');
  }

  void undoForfeitTurn() {
    _undoAddToPlayerScore();
    _undoAddToUsedWords();
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

  void _undoAddToPlayerScore({int? player}) {
    int penalizedPlayer = player ?? _currentPlayer!;

    int oldScore = _players!.elementAt(penalizedPlayer).playerScore!;
    int newScore = oldScore > 0 ? oldScore - 1 : oldScore;

    if (oldScore == 10) {
      _players!.elementAt(penalizedPlayer).isPlayerGameOver = false;

      notifyListeners();

      undoSetCurrentPlayer();
      _setPenalizedPlayer();
    }

    _players!.elementAt(penalizedPlayer).playerScore = newScore;

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

  void _undoAddToUsedWords() {
    if (_usedWords != null && _usedWords!.isNotEmpty) {
      String lastUsedWord = _usedWords!.last;
      _currentWord = lastUsedWord.substring(0, lastUsedWord.length - 1);

      _nextLetterTextFieldController.text =
          lastUsedWord.substring(lastUsedWord.length - 1, lastUsedWord.length);

      _usedWords!.removeLast();

      notifyListeners();
    }
  }

  void _addToGameHistory(String? event) {
    _gameHistory ??= [];
    _gameHistory!.add(event!);
  }

  void _resetGameHistory() {
    _gameHistory = null;

    notifyListeners();
  }

  void undo() {
    String lastAction = _gameHistory!.last;
    _redoUndoMap()[lastAction]!.call();
    _gameHistory!.removeLast();
    resetFocus();
  }
}


// TODO: Ability to click on a player name and perform an action on that specific player 
// TODO: Animate _countdownTimer using Animation and Tween
// TODO: Implement navigation in browser
// TODO: Disable some buttons for other players in online multiplayer
// TODO: DOUBLE SPACE FOR PAUSE