import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:ghosttears/providers/game_provider.dart';
import 'package:ghosttears/screens/desktop/game_screen.dart';
import 'package:ghosttears/screens/desktop/home_screen.dart';
import 'package:system_theme/system_theme.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:provider/provider.dart';

import 'theme.dart';

const String appTitle = 'GHOSTTEARS';

late bool darkMode;

bool get isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setPathUrlStrategy();

  if (defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.android ||
      kIsWeb) {
    darkMode = SystemTheme.isDarkMode;
    await SystemTheme.accentColor.load();
  } else {
    darkMode = true;
  }
  if (!kIsWeb &&
      [TargetPlatform.windows, TargetPlatform.linux]
          .contains(defaultTargetPlatform)) {
    flutter_acrylic.Window.hideWindowControls();

    await flutter_acrylic.Window.initialize();

    await flutter_acrylic.Window.setEffect(
      effect: flutter_acrylic.WindowEffect.acrylic,
      color: darkMode ? const Color(0xFF202020) : const Color(0xFFF3F3F3),
    );
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<GameProvider>(
            create: (context) => GameProvider()),
      ],
      child: const GhostTears(),
    ),
  );

  if (isDesktop) {
    doWhenWindowReady(() {
      final win = appWindow;
      win.minSize = const Size(410, 540);
      win.size = const Size(1255, 745);
      win.alignment = Alignment.center;
      win.title = appTitle;
      win.show();
    });
  }
}

class GhostTears extends StatelessWidget {
  const GhostTears({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppTheme(),
      builder: (context, _) {
        final appTheme = context.watch<AppTheme>();
        return FluentApp(
          title: appTitle,
          themeMode: appTheme.mode,
          debugShowCheckedModeBanner: false,
          initialRoute: '/home',
          routes: {
            '/home': (_) => const HomeScreen(),
            '/game': (_) => const GameScreen(),
          },
          theme: ThemeData(
            accentColor: appTheme.color,
            brightness: appTheme.mode == ThemeMode.system
                ? darkMode
                    ? Brightness.dark
                    : Brightness.light
                : appTheme.mode == ThemeMode.dark
                    ? Brightness.dark
                    : Brightness.light,
            visualDensity: VisualDensity.standard,
            focusTheme: FocusThemeData(
              glowFactor: is10footScreen() ? 2.0 : 0.0,
            ),
          ),
        );
      },
    );
  }
}
