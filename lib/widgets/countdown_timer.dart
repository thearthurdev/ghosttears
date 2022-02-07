import 'package:fluent_ui/fluent_ui.dart';

class CountdownTimer extends StatelessWidget {
  const CountdownTimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Countdown'),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              'four',
              style: TextStyle(fontSize: 80.0),
            ),
          ),
        ),
        Positioned(
          right: 0.0,
          top: -40.0,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '4',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 150.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}



    // decoration: BoxDecoration(
    //     color: darkMode ? const Color(0xFF2D2D2D) : Colors.white,
    //     borderRadius: BorderRadius.circular(8.0),
    //     border: Border.all(
    //       color: darkMode ? const Color(0xFF353535) : const Color(0xFFE5E5E5),
    //       width: 1.0,
    //     ),
    //     // boxShadow: [
    //     //   BoxShadow(
    //     //     blurRadius: 8.0,
    //     //     color: const Color(0xFF617884).withOpacity(0.1),
    //     //   ),
    //     // ],
    //   ),