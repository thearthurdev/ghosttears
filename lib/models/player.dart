class Player {
  final int? playerIndex;
  final int? playerID;
  String? playerName;
  int? playerScore;
  bool? isPlayerGameOver;

  Player({
    this.playerIndex,
    this.playerID,
    this.playerName,
    this.playerScore = 0,
    this.isPlayerGameOver = false,
  });
}
