import 'package:fluent_ui/fluent_ui.dart';

class WordChip extends StatelessWidget {
  const WordChip(this.text, {Key? key}) : super(key: key);

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6.0),
      child: Chip.selected(text: Text(text!)),
    );
  }
}
