import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:know_your_colleague_flutter/domain/scoreround.dart';
import 'package:know_your_colleague_flutter/pages/dashboard_page.dart';
import 'package:know_your_colleague_flutter/theme/material_color_generator.dart';
import 'package:know_your_colleague_flutter/theme/palette.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class GameFinishedPage extends StatelessWidget {
  const GameFinishedPage(this.score, {Key? key}) : super(key: key);
  final int score;

  @override
  Widget build(BuildContext context) {
    debugPrint('\x1B[32mScore is: $score\x1B[0m');
    return FutureBuilder(
      future: _saveAndGetScore(score),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          List<ScoreRound> scoreRounds = snapshot.data;
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "Dine poeng $score",
                style: const TextStyle(fontSize: 50.0),
              ),
              Text(
                "Poeng totalt fra de ti siste rundene ${_getSum(scoreRounds)}",
                style: const TextStyle(fontSize: 20.0),
              ),
              Expanded(
                  child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(20.0),
                children: _allScoreRoundsAsWidgets(scoreRounds),
              )),
            ],
          );
        } else if (snapshot.hasError) {
          return const Center(
              child: Text('Klarte ikke å finne poeng historikk :/'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

int _getSum(List<ScoreRound> scoreRounds) {
  var sum = 0;
  for (var element in scoreRounds) {
    sum += element.points;
  }
  return sum;
}

List<Widget> _allScoreRoundsAsWidgets(List<ScoreRound> scoreRounds) {
  return scoreRounds
      .map((scoreRound) => ListTile(
            title: Text(
              '${scoreRound.points}      ${scoreRound.date}',
              style: TextStyle(
                  fontSize: 20,
                  color: generateMaterialColor(Palette.secondary)),
            ),
          ))
      .toList();
}

Future<List<ScoreRound>> _saveAndGetScore(score) async {
  final prefs = await SharedPreferences.getInstance();

  List<ScoreRound> scoresList = [];
  String scoresAsString = prefs.getString('scores') ?? '';
  ScoreRound sr = ScoreRound(getDateAsString(), score);
  if (scoresAsString == '') {
    scoresList.add(sr);
  } else {
    scoresList = ScoreRound.decode(scoresAsString);
    var list = scoresList.where((item) => item.date == sr.date);
    if (list.isEmpty) {
      scoresList.add(sr);
    }
  }
  prefs.setString('scores', ScoreRound.encode(scoresList));

  var lastTen = scoresList;
  if (scoresList.length >= 10) {
    lastTen = scoresList.sublist(scoresList.length - 10);
  }

  lastTen.sort((x, y) => y.points - x.points);
  return lastTen;
}

String getDateAsString() {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  return dateFormat.format(DateTime.now().toLocal());
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const DashboardPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}
