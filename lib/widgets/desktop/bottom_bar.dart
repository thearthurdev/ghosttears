import 'package:fluent_ui/fluent_ui.dart';
import 'package:ghosttears/widgets/desktop/current_word.dart';
import 'package:ghosttears/widgets/desktop/game_actions.dart';
import 'package:ghosttears/widgets/desktop/next_word_text_field.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE5E5E5), width: 1.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            offset: const Offset(0.0, -0.4),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Row(
        children: const [
          Flexible(
            flex: 2,
            child: CurrentWord(),
          ),
          Flexible(
            flex: 1,
            child: NextWordTextField(),
          ),
          Expanded(
            flex: 2,
            child: GameActions(),
          ),
        ],
      ),
    );
  }
}