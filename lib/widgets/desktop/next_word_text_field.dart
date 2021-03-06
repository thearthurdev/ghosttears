import 'package:fluent_ui/fluent_ui.dart';
import 'package:ghosttears/providers/game_provider.dart';
import 'package:provider/provider.dart';
import 'package:system_theme/system_theme.dart';

class NextWordTextField extends StatefulWidget {
  const NextWordTextField({Key? key}) : super(key: key);

  @override
  State<NextWordTextField> createState() => _NextWordTextFieldState();
}

class _NextWordTextFieldState extends State<NextWordTextField> {
  late TextEditingController _controller;
  late FocusNode _nextLetterTextFieldFocusNode;

  @override
  void initState() {
    _controller = context.read<GameProvider>().nextLetterTextFieldController;
    _nextLetterTextFieldFocusNode =
        context.read<GameProvider>().nextLetterTextFieldFocusNode;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(builder: (context, provider, child) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: TextBox(
          controller: _controller,
          focusNode: _nextLetterTextFieldFocusNode,
          autocorrect: false,
          autofocus: true,
          maxLength: 1,
          header: 'Next Letter',
          cursorWidth: 2.0,
          cursorColor: SystemTheme.accentColor.accent.toAccentColor(),
          style: const TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
          onSubmitted: (entry) {
            if (entry.isNotEmpty) {
              provider.setCurrentWord(newLetter: entry);
              _controller.clear();
              provider.resetFocus();
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return ContentDialog(
                    title: const Text('Next letter not inputted'),
                    content: const Text(
                        'Please input the next letter and try again'),
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
              ).whenComplete(() => provider.resetFocus());
            }
          },
        ),
      );
    });
  }
}


//TODO: Live update all other players with input of current player in online multiplayer,