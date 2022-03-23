import 'package:fluent_ui/fluent_ui.dart';
import 'package:ghosttears/providers/game_provider.dart';
import 'package:provider/provider.dart';

class NextWordTextField extends StatefulWidget {
  const NextWordTextField({Key? key}) : super(key: key);

  @override
  State<NextWordTextField> createState() => _NextWordTextFieldState();
}

class _NextWordTextFieldState extends State<NextWordTextField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    _controller = TextEditingController();
    _focusNode = FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(builder: (context, provider, child) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: TextBox(
          controller: _controller,
          focusNode: _focusNode,
          autocorrect: false,
          autofocus: true,
          maxLength: 1,
          header: 'Next Letter',
          maxLengthEnforced: true,

          // textInputAction: //TODO: Live update all other players with input of current player in online multiplayer,
          onSubmitted: (entry) {
            if (entry.isNotEmpty) {
              provider.setCurrentWord(entry);
              _controller.clear();
              _focusNode.requestFocus();
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
              );
            }
          },
        ),
      );
    });
  }
}
