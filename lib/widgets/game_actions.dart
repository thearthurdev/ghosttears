import 'package:fluent_ui/fluent_ui.dart';
import 'package:ghosttears/providers/game_provider.dart';
import 'package:provider/provider.dart';

class GameActions extends StatelessWidget {
  const GameActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(builder: (context, provider, child) {
      return Container(
        // color: Colors.orange,
        padding: const EdgeInsets.all(26.0),
        child: FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  FluentIcons.cancel,
                  size: 16.0,
                ),
                onPressed: () {
                  provider.markWrongWord();
                },
              ),
              const SizedBox(width: 12.0),
              IconButton(
                icon: const Icon(
                  FluentIcons.accept,
                  size: 16.0,
                ),
                onPressed: () {
                  provider.markCompleteWord();
                },
              ),
              const SizedBox(width: 12.0),
              const PlayStateTimerButton(),
              const SizedBox(width: 12.0),
              IconButton(
                icon: const Icon(
                  FluentIcons.stop,
                  size: 16.0,
                ),
                onPressed: () {},
              ),
              const SizedBox(width: 12.0),
              IconButton(
                icon: const Icon(
                  FluentIcons.reset,
                  size: 16.0,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      );
    });
  }
}

class PlayStateTimerButton extends StatelessWidget {
  const PlayStateTimerButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(builder: (context, provider, child) {
      return Stack(
        children: [
          const Positioned(
            top: 1.4,
            left: 2.0,
            child: ProgressRing(
              backwards: true,
              // value: 25.0,
            ),
          ),
          IconButton(
            style: ButtonStyle(shape: ButtonState.all(const CircleBorder())),
            icon: Icon(
              provider.isGamePaused == true
                  ? FluentIcons.pause
                  : FluentIcons.play,
              size: 24.0,
            ),
            onPressed: () {
              provider.setGamePaused();
            },
          ),
        ],
      );
    });
  }
}


// TODO: Add button to enter space and special characters 