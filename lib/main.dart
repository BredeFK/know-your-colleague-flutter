import 'package:flutter/material.dart';
import 'package:know_your_colleague_flutter/pages/colleagues_page.dart';
import 'package:know_your_colleague_flutter/pages/dashboard_page.dart';
import 'package:know_your_colleague_flutter/pages/game_finished_page.dart';
import 'package:know_your_colleague_flutter/pages/game_pages.dart';
import 'package:know_your_colleague_flutter/theme/material_color_generator.dart';
import 'package:know_your_colleague_flutter/theme/palette.dart';

void main() {
  runApp(const MainAppWidget());
}

class MainAppWidget extends StatelessWidget {
  const MainAppWidget({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Know your colleague',
      routes: {
        '': (context) => const DashboardPage(),
        '/game': (context) => const GamePage()
      },
      theme: ThemeData(
          primarySwatch: generateMaterialColor(Palette.primary),
          scaffoldBackgroundColor: generateMaterialColor(Palette.background),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                primary: generateMaterialColor(Palette.secondary)),
          ),
          textTheme: TextTheme(
            bodyText1: TextStyle(color: generateMaterialColor(Palette.text)),
            bodyText2: TextStyle(color: generateMaterialColor(Palette.text)),
            headline1: TextStyle(color: generateMaterialColor(Palette.text)),
            headline2: TextStyle(color: generateMaterialColor(Palette.text)),
            headline3: TextStyle(color: generateMaterialColor(Palette.text)),
            headline4: TextStyle(color: generateMaterialColor(Palette.text)),
            headline5: TextStyle(color: generateMaterialColor(Palette.text)),
            headline6: TextStyle(color: generateMaterialColor(Palette.text)),
            subtitle1: TextStyle(color: generateMaterialColor(Palette.text)),
            subtitle2: TextStyle(color: generateMaterialColor(Palette.text)),
          )),
      initialRoute: '',
    );
  }
}
