import 'package:fluent_ui/fluent_ui.dart';
import 'package:ghosttears/widgets/word_chip.dart';

class LeftSide extends StatelessWidget {
  const LeftSide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Typography typography = FluentTheme.of(context).typography;

    return SizedBox(
      width: 300.0,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 16.0),
                  const ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30.0,
                      child: Icon(FluentIcons.drop_shape),
                    ),
                    title: Text(
                      'GHOSTTEARS',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text('Don\'t get caught counting'),
                  ),
                  const SizedBox(height: 16.0),
                  const TextBox(
                    suffix: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(FluentIcons.full_history),
                    ),
                    placeholder: 'Used words',
                  ),
                  Expanded(
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(scrollbars: false),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 8.0),
                        child: Wrap(
                          children: const [
                            WordChip('Ghana'),
                            WordChip('Trinidad and Tobago'),
                            WordChip('China'),
                            WordChip('China'),
                            WordChip('China'),
                            WordChip('Gambia'),
                            WordChip('Mozambique'),
                            WordChip('Lithuania'),
                            WordChip('Comoros'),
                            WordChip('United Kingdom'),
                            WordChip('Lithuania'),
                            WordChip('Ghana'),
                            WordChip('China'),
                            WordChip('Gambia'),
                            WordChip('Mozambique'),
                            WordChip('Comoros'),
                            WordChip('United Kingdom'),
                            WordChip('Kuwait'),
                            WordChip('China'),
                            WordChip('Lithuania'),
                            WordChip('Ghana'),
                            WordChip('Kuwait'),
                            WordChip('Comoros'),
                            WordChip('Comoros'),
                            WordChip('Trinidad and Tobago'),
                            WordChip('United Kingdom'),
                            WordChip('Mozambique'),
                            WordChip('Lithuania'),
                            WordChip('Gambia'),
                            WordChip('Kuwait'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
