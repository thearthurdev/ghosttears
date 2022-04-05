import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:ghosttears/providers/game_provider.dart';
import 'package:ghosttears/screens/desktop/base_screen.dart';
import 'package:ghosttears/screens/desktop/game_screen.dart';
import 'package:ghosttears/utils/navigator.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(builder: (context, provider, child) {
      return BaseScreen(
        showBackButton: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'GHOSTTEARS',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 38.0,
              ),
            ),
            const SizedBox(height: 16.0),
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 260.0,
              ),
              child: Combobox<int>(
                placeholder: const Text('Select number of players'),
                isExpanded: true,
                items: [2, 3, 4, 5, 6]
                    .map((e) => ComboboxItem<int>(
                          value: e,
                          child: e > 1
                              ? Text('$e Players')
                              : Text('$e Player vs Computer'),
                        ))
                    .toList(),
                value: provider.playerCount,
                onChanged: (value) {
                  if (value != null) {
                    provider.setPlayerCount(value);
                  }
                },
              ),
            ),
            provider.playerCount != null
                ? Container(
                    margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.02),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Wrap(
                      runAlignment: WrapAlignment.center,
                      children: List.generate(provider.playerCount!, (index) {
                        return PlayerSetup(index);
                      }),
                    ),
                  )
                : const SizedBox(),
            const SizedBox(height: 16.0),
            Flexible(
              child: Button(
                child: const Text('Play'),
                onPressed: () {
                  if (provider.playerCount != null) {
                    context
                        .navigate(const GameScreen())
                        .whenComplete(() => provider.startNewGame());
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return ContentDialog(
                          title: const Text('Number of players not selected'),
                          content: const Text(
                              'Please select the number of players and try again'),
                          actions: [
                            Button(
                              child: const Text('Ok'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      );
    });
  }
}

class PlayerSetup extends StatelessWidget {
  const PlayerSetup(
    this.index, {
    Key? key,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(builder: (context, provider, child) {
      return Container(
        width: 120.0,
        margin: const EdgeInsets.all(8.0),
        // color: Colors.white,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xFFE5E5E5),
                  width: 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    offset: const Offset(0.0, 0.8),
                  ),
                ],
              ),
              child: CircleAvatar(
                minRadius: 24.0,
                maxRadius: 32.0,
                backgroundColor: Colors.white,
                child: Text(
                  provider.players![index].playerName!.substring(
                      0,
                      provider.players![index].playerName!.length > 2
                          ? 2
                          : provider.players![index].playerName!.length),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: provider.players![index].isPlayerGameOver == true
                        ? Colors.black.withOpacity(0.3)
                        : Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextBox(
              placeholder: 'Player ${index + 1}',
              textCapitalization: TextCapitalization.words,
              onChanged: (input) {
                provider.changePlayerName(index, input);
              },
            ),
          ],
        ),
      );
    });
  }
}
