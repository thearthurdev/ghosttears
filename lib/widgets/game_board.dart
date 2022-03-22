import 'package:fluent_ui/fluent_ui.dart';
import 'package:ghosttears/providers/game_provider.dart';
import 'package:provider/provider.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double windowWidth = MediaQuery.of(context).size.width;
    double windowHeight = MediaQuery.of(context).size.height;

    return Consumer<GameProvider>(builder: (context, provider, child) {
      return Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: windowWidth * 0.04,
            vertical: windowHeight * 0.08,
          ),
          child: FittedBox(
            alignment: Alignment.center,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                      SizedBox(height: 8.0),
                      GhostTearsCard(
                        playerScore: 10,
                      ),
                    ] +
                    List.generate(provider.playerCount!, (int index) {
                      return GhostTearsCard(
                        playerID: provider.players![index].playerID,
                        playerName: provider.players![index].playerName,
                        playerScore: provider.players![index].playerScore,
                      );
                    })
                ),
          ),
        ),
      );
    });
  }
}

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
                          ? Colors.green.lighter
                          : const Color(0xFFE5E5E5),
                      width: isCurrentPlayer ? 3.0 : 1.0,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 24.0,
                    child: Text(
                      playerName!.length > 1
                          ? playerName!.substring(0, 2)
                          : playerName!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              : const SizedBox(width: 48.0),
          SizedBox(width: isCurrentPlayer ? 12.0 : 16.0),
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
  final TextStyle wordTextStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 48.0,
  );

  const GhostLetter(
    this.letter, {
    this.isUserCard = false,
    Key? key,
  }) : super(key: key);

  final String letter;
  final bool isUserCard;

  @override
  Widget build(BuildContext context) {
    double windowWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: windowWidth * 0.002),
      width: 68.0,
      height: 68.0,
      decoration: BoxDecoration(
        color: isUserCard ? Colors.white : const FluentApp().theme?.accentColor,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: const Color(0xFFE5E5E5), width: 1.0),
      ),
      child: Center(
        child: Text(letter, style: wordTextStyle),
      ),
    );
  }
}
