import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';

class CurrentWord extends StatelessWidget {
  const CurrentWord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Center(
        child: TextBox(
          padding: const EdgeInsets.all(12.0),
          textCapitalization: TextCapitalization.words,
          enableSuggestions: false,
          enableInteractiveSelection: false,
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
