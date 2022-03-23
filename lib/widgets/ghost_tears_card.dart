import 'package:fluent_ui/fluent_ui.dart';
import 'package:system_theme/system_theme.dart';

class GhostTearsCard extends StatelessWidget {
  const GhostTearsCard({
    this.playerID,
    this.playerName,
    required this.playerScore,
    this.isCurrentPlayer = false,
    Key? key,
  }) : super(key: key);

  final int? playerID;
  final String? playerName;
  final int? playerScore;
  final bool isCurrentPlayer;

  @override
  Widget build(BuildContext context) {
    double windowWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(vertical: windowWidth * 0.002),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          playerName != null
              ? Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                      playerName!.length > 1
                          ? playerName!.substring(0, 2)
                          : playerName!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
              : const SizedBox(width: 48.0),
          SizedBox(width: isCurrentPlayer ? 10.0 : 16.0),
          Row(
            children: [
              GhostLetter(playerScore! >= 1 ? 'G' : ''),
              GhostLetter(playerScore! >= 2 ? 'H' : ''),
              GhostLetter(playerScore! >= 3 ? 'O' : ''),
              GhostLetter(playerScore! >= 4 ? 'S' : ''),
              GhostLetter(playerScore! >= 5 ? 'T' : ''),
              GhostLetter(playerScore! >= 6 ? 'T' : ''),
              GhostLetter(playerScore! >= 7 ? 'E' : ''),
              GhostLetter(playerScore! >= 8 ? 'A' : ''),
              GhostLetter(playerScore! >= 9 ? 'R' : ''),
              GhostLetter(playerScore! >= 10 ? 'S' : ''),
            ],
          ),
        ],
      ),
    );
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
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
          color: const Color(0xFF000000).withOpacity(0.08),
          width: 1.2,
        ),
      ),
      child: Center(
        child: Text(
          letter,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 48.0,
          ),
        ),
      ),
    );
  }
}
