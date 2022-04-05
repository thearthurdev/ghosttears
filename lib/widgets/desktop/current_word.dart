import 'package:fluent_ui/fluent_ui.dart';
import 'package:ghosttears/providers/game_provider.dart';
import 'package:provider/provider.dart';

class CurrentWord extends StatelessWidget {
  const CurrentWord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(builder: (context, provider, child) {
      return Container(
        // color: Colors.green,
        padding: const EdgeInsets.fromLTRB(12.0, 4.0, 12.0, 8.0),
        child: Stack(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Current Word'),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: provider.currentWord == null
                    ? Text(
                        '...',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.2),
                        ),
                      )
                    : FittedBox(
                        child: Text(
                          provider.currentWord!,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
