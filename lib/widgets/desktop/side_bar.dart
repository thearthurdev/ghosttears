import 'package:fluent_ui/fluent_ui.dart';
import 'package:ghosttears/providers/game_provider.dart';
import 'package:ghosttears/widgets/desktop/word_chip.dart';
import 'package:provider/provider.dart';
import 'package:system_theme/system_theme.dart';

class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Typography typography = FluentTheme.of(context).typography;

    return Consumer<GameProvider>(builder: (context, provider, child) {
      return SizedBox(
        width: 300.0,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 16.0),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 30.0,
                        child: Icon(
                          FluentIcons.drop_shape,
                          color: SystemTheme.accentColor.accent.toAccentColor(),
                        ),
                      ),
                      title: const Text(
                        'GHOSTTEARS',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: const Text('Don\'t get caught counting'),
                    ),
                    const SizedBox(height: 16.0),
                    UsedWordsSearchTextField(),
                    Expanded(
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context)
                            .copyWith(scrollbars: false),
                        child: provider.usedWords != null
                            ? SingleChildScrollView(
                                padding: const EdgeInsets.fromLTRB(
                                    0.0, 8.0, 8.0, 8.0),
                                child: Wrap(
                                  children: List.generate(
                                    provider.usedWords!.length,
                                    (index) =>
                                        WordChip(provider.usedWords![index]),
                                  ),
                                ),
                              )
                            : const Center(
                                child: Text('No words used yet'),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class UsedWordsSearchTextField extends StatelessWidget {
  UsedWordsSearchTextField({Key? key}) : super(key: key);

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(builder: (context, provider, child) {
      return AutoSuggestBox(
        controller: _controller,
        items: provider.usedWords != null ? provider.usedWords! : [],
        placeholder: 'Used Words',
        trailingIcon: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Icon(FluentIcons.full_history),
        ),
        onSelected: (value) {},
      );
    });
  }
}
