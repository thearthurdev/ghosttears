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
              const GameActionButton(
                icon: FluentIcons.undo,
                tooltip: 'Undo previous action',
              ),
              GameActionButton(
                icon: FluentIcons.cancel,
                tooltip: 'Mark word as wrong',
                onPressed: () => provider.markWrongWord(),
              ),
              GameActionButton(
                icon: FluentIcons.accept,
                tooltip: 'Mark word as complete',
                onPressed: () => provider.markCompleteWord(),
              ),
              const GamePlayStateTimerButton(),
              const GameActionButton(
                icon: FluentIcons.forward,
                tooltip: 'Stop the game',
              ),
              GameActionButton(
                icon: FluentIcons.reset,
                tooltip: 'Reset the game',
                onPressed: () => provider.resetGame(),
              ),
              const GameActionButton(
                icon: FluentIcons.more_vertical,
                tooltip: 'More actions',
              ),
            ],
          ),
        ),
      );
    });
  }
}

class GameActionButton extends StatelessWidget {
  const GameActionButton({
    this.icon,
    this.iconSize = 16.0,
    this.onPressed,
    this.tooltip,
    Key? key,
  }) : super(key: key);

  final IconData? icon;
  final double? iconSize;
  final VoidCallback? onPressed;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: IconButton(
          icon: Icon(
            icon!,
            size: iconSize,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}

class GamePlayStateTimerButton extends StatelessWidget {
  const GamePlayStateTimerButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(builder: (context, provider, child) {
      return Tooltip(
        message: provider.isGamePaused == true
            ? 'Unpause the timer'
            : 'Pause the timer',
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Stack(
            children: [
              const Positioned(
                top: 2.0,
                left: 2.0,
                child: ProgressRing(
                  backwards: true,
                  // value: 25.0,
                ),
              ),
              IconButton(
                style:
                    ButtonStyle(shape: ButtonState.all(const CircleBorder())),
                icon: Icon(
                  provider.isGamePaused == true
                      ? FluentIcons.play
                      : FluentIcons.pause,
                  size: 24.0,
                ),
                onPressed: () {
                  provider.setGamePaused();
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}


// TODO: Add button to enter space and special characters 