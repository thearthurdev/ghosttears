class Player {
  final int? playerID;
  final String? playerName;
  int? playerScore;
  bool? isGameOver;

  Player(
    this.playerID,
    this.playerName,
    this.playerScore, {
    this.isGameOver,
  });
}
