import 'package:fluent_ui/fluent_ui.dart';
import 'package:ghosttears/screens/desktop/base_screen.dart';
import 'package:ghosttears/widgets/desktop/bottom_bar.dart';
import 'package:ghosttears/widgets/desktop/game_board.dart';
import 'package:ghosttears/widgets/desktop/side_bar.dart';

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
                SideBar(),
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
