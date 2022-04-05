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
              GameActionButton(
                icon: FluentIcons.blocked,
                tooltip: 'Forfeit turn',
                onPressed: () => provider.forfeitTurn(),
              ),
              const GamePlayStateTimerButton(),
              GameActionButton(
                icon: FluentIcons.undo,
                tooltip: 'Undo previous action',
                onPressed: provider.gameHistory != null &&
                        provider.gameHistory!.isNotEmpty
                    ? () => provider.undo()
                    : null,
              ),
              // const GameActionButton(
              //   icon: FluentIcons.redo,
              //   tooltip: 'Redo previous action',
              // ),
              GameActionButton(
                icon: FluentIcons.reset,
                tooltip: 'Reset game',
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

class GamePlayStateTimerButton extends StatefulWidget {
  const GamePlayStateTimerButton({
    Key? key,
  }) : super(key: key);

  @override
  State<GamePlayStateTimerButton> createState() =>
      _GamePlayStateTimerButtonState();
}

class _GamePlayStateTimerButtonState extends State<GamePlayStateTimerButton> {
  late GameProvider _gameProvider;

  @override
  void initState() {
    _gameProvider = GameProvider();
    super.initState();
  }

  @override
  void dispose() {
    _gameProvider.cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(builder: (context, provider, child) {
      return Tooltip(
        message:
            provider.isGamePaused == true ? 'Unpause timer' : 'Pause timer',
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Stack(
            children: [
              Positioned(
                top: 2.0,
                left: 2.0,
                child: ProgressRing(
                  backwards: true,
                  value: provider.countdownPercentage,
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
                onPressed: () => provider.setGamePausedState(),
              ),
            ],
          ),
        ),
      );
    });
  }
}


// TODO: Add button to enter space and special characters 