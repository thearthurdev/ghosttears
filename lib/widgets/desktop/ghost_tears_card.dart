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
      int? playerIndex = player!.playerIndex;
      String? playerName = player!.playerName;
      int? playerScore = player!.playerScore ??= 10;
      bool? isPlayerGameOver = player!.isPlayerGameOver;
      bool? isCurrentPlayer = playerIndex == provider.currentPlayer;

      List<String> ghosttears = [
        playerScore >= 1 ? 'G' : '',
        playerScore >= 2 ? 'H' : '',
        playerScore >= 3 ? 'O' : '',
        playerScore >= 4 ? 'S' : '',
        playerScore >= 5 ? 'T' : '',
        playerScore >= 6 ? 'T' : '',
        playerScore >= 7 ? 'E' : '',
        playerScore >= 8 ? 'A' : '',
        playerScore >= 9 ? 'R' : '',
        playerScore >= 10 ? 'S' : '',
      ];

      return Container(
        margin: EdgeInsets.symmetric(vertical: windowWidth * 0.002),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            playerName != null
                ? PlayerIcon(player!)
                : const SizedBox(width: 48.0),
            SizedBox(width: isCurrentPlayer ? 10.0 : 16.0),
            Row(
              children: List.generate(
                ghosttears.length,
                (index) => GhostLetter(
                  ghosttears[index],
                  isPlayerGameOver: isPlayerGameOver,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class PlayerIcon extends StatelessWidget {
  const PlayerIcon(this.player, {Key? key}) : super(key: key);

  final Player player;

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(builder: (context, provider, child) {
      int? _playerIndex = player.playerIndex;
      String? _playerName = player.playerName;
      bool? _isPlayerGameOver = player.isPlayerGameOver;
      bool? _isCurrentPlayer = _playerIndex == provider.currentPlayer;
      bool? _isSelectedPlayer = _playerIndex == provider.selectedPlayer;

      Color _backgroundColor() {
        if (_isPlayerGameOver == true) {
          return Colors.black.withOpacity(0.4);
        }
        if (_isSelectedPlayer == true) {
          return SystemTheme.accentColor.accent.toAccentColor();
        }
        return Colors.white;
      }

      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _backgroundColor(),
          border: Border.all(
            color: _isCurrentPlayer
                ? SystemTheme.accentColor.accent.toAccentColor()
                : const Color(0xFFE5E5E5),
            width: _isCurrentPlayer ? 4.0 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              offset: const Offset(0.0, 0.8),
            ),
          ],
        ),
        child: Button(
          style: ButtonStyle(
            shape: ButtonState.all(const CircleBorder()),
            elevation: ButtonState.all(0.0),
            padding: ButtonState.all(EdgeInsets.zero),
          ),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 24.0,
            child: Text(
              _playerName!.length > 1
                  ? _playerName.substring(0, 2)
                  : _playerName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: _isPlayerGameOver == true
                    ? Colors.black.withOpacity(0.3)
                    : Colors.black,
              ),
            ),
          ),
          onPressed: () => provider.toggleSelectedPlayer(player.playerIndex!),
        ),
      );
    });
  }
}

class GhostLetter extends StatelessWidget {
  const GhostLetter(
    this.letter, {
    this.isUserCard,
    this.isPlayerGameOver,
    Key? key,
  }) : super(key: key);

  final String letter;
  final bool? isUserCard;
  final bool? isPlayerGameOver;

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
              color: isPlayerGameOver!
                  ? Colors.black.withOpacity(0.2)
                  : Colors.black),
        ),
      ),
    );
  }
}
