class Player {
  final int? playerID;
  String? playerName;
  int? playerScore;
  bool? isPlayerGameOver;

  Player({
    this.playerID,
    this.playerName,
    this.playerScore = 0,
    this.isPlayerGameOver = false,
  });
}
