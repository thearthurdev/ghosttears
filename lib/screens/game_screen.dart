import 'package:fluent_ui/fluent_ui.dart';
import 'package:ghosttears/screens/base_screen.dart';

import '../widgets/bottom_bar.dart';
import '../widgets/side_bar.dart';
import '../widgets/game_board.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: const [
                LeftSide(),
                GameBoard(),
              ],
            ),
          ),
          const BottomBar(),
        ],
      ),
    );
  }
}
