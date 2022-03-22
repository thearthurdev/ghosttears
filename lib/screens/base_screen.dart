import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:ghosttears/widgets/windows_buttons.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({
    required this.child,
    this.showBackButton = true,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kIsWeb ? const Color(0xFFF3F3F3) : null,
      child: Column(
        children: [
          WindowTitleBarBox(
            child: MoveWindow(
              child: WindowButtons(
                showBackButton: showBackButton,
              ),
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
