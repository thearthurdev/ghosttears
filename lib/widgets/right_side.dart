import 'package:fluent_ui/fluent_ui.dart';

class RightSide extends StatelessWidget {
  const RightSide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double windowWidth = MediaQuery.of(context).size.width;
    double windowHeight = MediaQuery.of(context).size.height;

    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: windowWidth * 0.04,
          vertical: windowHeight * 0.08,
        ),
        child: FittedBox(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SizedBox(height: 8.0),
              GhostTearsCard(
                score: 10,
              ),
              GhostTearsCard(
                score: 3,
                userName: 'Sam',
              ),
              GhostTearsCard(
                score: 5,
                userName: 'Val',
                isCurrentPlayer: true,
              ),
              GhostTearsCard(
                score: 1,
                userName: 'Joe',
              ),
              GhostTearsCard(
                score: 9,
                userName: 'Mante',
              ),
              GhostTearsCard(
                score: 3,
                userName: 'David',
              ),
              GhostTearsCard(
                score: 5,
                userName: 'Diabene',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GhostTearsCard extends StatelessWidget {
  const GhostTearsCard({
    required this.score,
    this.userName,
    this.isCurrentPlayer = false,
    Key? key,
  }) : super(key: key);

  final int? score;
  final String? userName;
  final bool isCurrentPlayer;

  @override
  Widget build(BuildContext context) {
    double windowWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(vertical: windowWidth * 0.002),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          userName != null
              ? Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: isCurrentPlayer
                          ? Colors.green.lighter
                          : const Color(0xFFE5E5E5),
                      width: isCurrentPlayer ? 3.0 : 1.0,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 24.0,
                    child: Text(
                      userName!.substring(0, 2),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              : const SizedBox(width: 48.0),
          SizedBox(width: isCurrentPlayer ? 12.0 : 16.0),
          Row(
            children: [
              GhostLetter(score! >= 1 ? 'G' : ''),
              GhostLetter(score! >= 2 ? 'H' : ''),
              GhostLetter(score! >= 3 ? 'O' : ''),
              GhostLetter(score! >= 4 ? 'S' : ''),
              GhostLetter(score! >= 5 ? 'T' : ''),
              GhostLetter(score! >= 6 ? 'T' : ''),
              GhostLetter(score! >= 7 ? 'E' : ''),
              GhostLetter(score! >= 8 ? 'A' : ''),
              GhostLetter(score! >= 9 ? 'R' : ''),
              GhostLetter(score! >= 10 ? 'S' : ''),
            ],
          ),
        ],
      ),
    );
  }
}

class GhostLetter extends StatelessWidget {
  final TextStyle wordTextStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 48.0,
  );

  const GhostLetter(
    this.letter, {
    Key? key,
  }) : super(key: key);

  final String letter;

  @override
  Widget build(BuildContext context) {
    double windowWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: windowWidth * 0.002),
      width: 68.0,
      height: 68.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: const Color(0xFFE5E5E5), width: 1.0),
      ),
      child: Center(
        child: Text(letter, style: wordTextStyle),
      ),
    );
  }
}
