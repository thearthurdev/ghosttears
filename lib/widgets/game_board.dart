import 'package:fluent_ui/fluent_ui.dart';
import 'package:ghosttears/models/player.dart';
import 'package:ghosttears/providers/game_provider.dart';
import 'package:ghosttears/widgets/ghost_tears_card.dart';
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
            horizontal: windowWidth * 0.06,
            vertical: windowHeight * 0.08,
          ),
          child: FittedBox(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                    const SizedBox(height: 8.0),
                    GhostTearsCard(player: Player(playerScore: 10)),
                  ] +
                  List.generate(provider.playerCount!, (int index) {
                    return GhostTearsCard(
                      player: provider.players![index],
                    );
                  }) +
                  [],
            ),
          ),
        ),
      );
    });
  }
}
