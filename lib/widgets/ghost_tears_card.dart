import 'package:fluent_ui/fluent_ui.dart';
import 'package:ghosttears/models/player.dart';
import 'package:ghosttears/providers/game_provider.dart';
import 'package:provider/provider.dart';
import 'package:system_theme/system_theme.dart';

class GhostTearsCard extends StatelessWidget {
  const GhostTearsCard({
    this.player,
    Key? key,
  }) : super(key: key);

  final Player? player;

  @override
  Widget build(BuildContext context) {
    double windowWidth = MediaQuery.of(context).size.width;

    return Consumer<GameProvider>(builder: (context, provider, child) {
      int? playerID = player!.playerID;
      String? playerName = player!.playerName;
      int? playerScore = player!.playerScore ??= 10;
      bool? isGameOver = player!.isGameOver;
      bool? isCurrentPlayer = playerID == provider.currentPlayer;

      return Container(
        margin: EdgeInsets.symmetric(vertical: windowWidth * 0.002),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            playerName != null
                ? Container(
                    decoration: BoxDecoration(
                      color: isGameOver == true
                          ? Colors.black.withOpacity(0.4)
                          : Colors.white,
                      border: Border.all(
                        color: isCurrentPlayer
                            ? SystemTheme.accentInstance.accent.toAccentColor()
                            : const Color(0xFFE5E5E5),
                        width: isCurrentPlayer ? 4.0 : 1.0,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.8),
                      radius: 24.0,
                      child: Text(
                        playerName.length > 1
                            ? playerName.substring(0, 2)
                            : playerName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isGameOver == true
                              ? Colors.black.withOpacity(0.3)
                              : Colors.black,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(width: 48.0),
            SizedBox(width: isCurrentPlayer ? 10.0 : 16.0),
            Row(
              children: [
                GhostLetter(
                  playerScore >= 1 ? 'G' : '',
                  isGameOver: player!.isGameOver,
                ),
                GhostLetter(
                  playerScore >= 2 ? 'H' : '',
                  isGameOver: player!.isGameOver,
                ),
                GhostLetter(
                  playerScore >= 3 ? 'O' : '',
                  isGameOver: player!.isGameOver,
                ),
                GhostLetter(
                  playerScore >= 4 ? 'S' : '',
                  isGameOver: player!.isGameOver,
                ),
                GhostLetter(
                  playerScore >= 5 ? 'T' : '',
                  isGameOver: player!.isGameOver,
                ),
                GhostLetter(
                  playerScore >= 6 ? 'T' : '',
                  isGameOver: player!.isGameOver,
                ),
                GhostLetter(
                  playerScore >= 7 ? 'E' : '',
                  isGameOver: player!.isGameOver,
                ),
                GhostLetter(
                  playerScore >= 8 ? 'A' : '',
                  isGameOver: player!.isGameOver,
                ),
                GhostLetter(
                  playerScore >= 9 ? 'R' : '',
                  isGameOver: player!.isGameOver,
                ),
                GhostLetter(
                  playerScore >= 10 ? 'S' : '',
                  isGameOver: player!.isGameOver,
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}

class GhostLetter extends StatelessWidget {
  const GhostLetter(
    this.letter, {
    this.isUserCard,
    this.isGameOver,
    Key? key,
  }) : super(key: key);

  final String letter;
  final bool? isUserCard;
  final bool? isGameOver;

  @override
  Widget build(BuildContext context) {
    double windowWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: windowWidth * 0.002),
      width: 68.0,
      height: 68.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
          color: const Color(0xFF000000).withOpacity(0.08),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            offset: const Offset(0.0, 0.8),
          ),
        ],
      ),
      child: Center(
        child: Text(
          letter,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 48.0,
              color:
                  isGameOver! ? Colors.black.withOpacity(0.2) : Colors.black),
        ),
      ),
    );
  }
}
