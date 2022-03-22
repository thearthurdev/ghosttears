import 'package:fluent_ui/fluent_ui.dart';

class GameActions extends StatelessWidget {
  const GameActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // IconButton(
            //   icon: const Icon(
            //     FluentIcons.accept,
            //     size: 32.0,
            //   ),
            //   onPressed: () {},
            // ),
            // IconButton(
            //   icon: const Icon(
            //     FluentIcons.circle_pause,
            //     size: 32.0,
            //   ),
            //   onPressed: () {},
            // ),
            // IconButton(
            //   icon: const Icon(
            //     FluentIcons.circle_pause,
            //     size: 48.0,
            //   ),
            //   onPressed: () {},
            // ),
            // IconButton(
            //   icon: const Icon(
            //     FluentIcons.circle_pause,
            //     size: 32.0,
            //   ),
            //   onPressed: () {},
            // ),
            IconButton(
              icon: const Icon(
                FluentIcons.circle_pause,
                size: 32.0,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
