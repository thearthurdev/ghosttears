import 'package:fluent_ui/fluent_ui.dart';
import 'package:ghosttears/providers/game_provider.dart';
import 'package:ghosttears/screens/base_screen.dart';
import 'package:ghosttears/screens/game_screen.dart';
import 'package:ghosttears/utils/navigator.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(builder: (context, provider, child) {
      return BaseScreen(
        showBackButton: false,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 260.0,
          ),
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
              Combobox<int>(
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
              const SizedBox(height: 16.0),
              Flexible(
                child: Button(
                  child: const Text('Play'),
                  onPressed: () {
                    if (provider.playerCount != null) {
                      provider.startNewGame();
                      context.navigate(const GameScreen());
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
        ),
      );
    });
  }
}
