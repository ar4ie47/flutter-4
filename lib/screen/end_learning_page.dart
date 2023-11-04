import 'package:anki/component/neumorph_conteiner.dart';
import 'package:anki/screen/folder_screen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../constant/colors.dart';
import '../utils/neumorph_icon.dart';
import 'learning_page.dart';

class LearningCompletedPage extends StatelessWidget {
  String folderName;
  List<LearningCard> cards;

  LearningCompletedPage(
      {super.key, required this.cards, required this.folderName});

  @override
  Widget build(BuildContext context) {
    var isSuccess = cards.where((element) => element.isSuccess).length;
    var isFail = cards.where((element) => !element.isSuccess).length;
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const FolderPage()),
                    (Route<dynamic> route) => false);
              },
              icon: const Icon(Icons.arrow_back_rounded)),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.add,
                  color: DarkColors.background,
                ))
          ],
          backgroundColor: DarkColors.background,
          title: Center(
              child: Text("ANKI",
                  style: Theme.of(context).textTheme.headlineLarge))),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
        child: Column(
          children: [
            Expanded(
                flex: 60,
                child: NeumorphicContainer(
                  padding: const EdgeInsets.all(24),
                  child: AnkiCharts(cards: cards),
                )),
            const Expanded(flex: 40, child: SizedBox()),
            Expanded(
                flex: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NeumorphicIcon(
                        icon: const Icon(Icons.refresh),
                        iconColor: DarkColors.greenIcon,
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LearningPage(folderName: folderName))))
                  ],
                )),
          ],
        ),
      )),
    );
  }
}

class AnkiCharts extends StatelessWidget {
  List<LearningCard> cards;

  AnkiCharts({Key? key, required this.cards}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isSuccess = cards.where((element) => element.isSuccess).length;
    var isFail = cards.where((element) => !element.isSuccess).length;
    var length = cards.length.toDouble();
    var width = 30.0;
    var borderRadius = 4.0;
    return BarChart(BarChartData(
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          topTitles: falseShowTitles(),
          leftTitles: falseShowTitles(),
          rightTitles: falseShowTitles(),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true, getTitlesWidget: getBottomTittles)),
        ),
        maxY: length,
        minY: 0,
        barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
                tooltipBgColor: DarkColors.primary,
                getTooltipItem: getTooltipItem)),
        barGroups: [
          BarChartGroupData(x: 0, barRods: [
            BarChartRodData(
                color: DarkColors.redIcon,
                gradient:
                    getGradient(DarkColors.redIcon, DarkColors.snackBarError),
                backDrawRodData: BackgroundBarChartRodData(
                    show: true, color: DarkColors.shadowLight, toY: length),
                toY: isFail.toDouble(),
                width: width,
                borderRadius: BorderRadius.circular(borderRadius))
          ], showingTooltipIndicators: []),
          BarChartGroupData(x: 1, barRods: [
            BarChartRodData(
                gradient: getGradient(
                    DarkColors.snackBarSuccess, DarkColors.greenIcon),
                backDrawRodData: BackgroundBarChartRodData(
                    show: true, color: DarkColors.shadowLight, toY: length),
                toY: isSuccess.toDouble(),
                color: DarkColors.greenIcon,
                width: width,
                borderRadius: BorderRadius.circular(borderRadius))
          ])
        ]));
  }

  LinearGradient getGradient(Color bottomColor, Color topColor) {
    return LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [bottomColor, topColor]);
  }

  AxisTitles falseShowTitles() =>
      const AxisTitles(sideTitles: SideTitles(showTitles: false));

  SideTitleWidget getBottomTittles(double value, TitleMeta meta) {
    return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text(value.toInt() == 0 ? "Fail" : "Success"));
  }

  BarTooltipItem getTooltipItem(BarChartGroupData group, int groupIndex,
      BarChartRodData rod, int rodIndex) {
    var color = rod.color ?? DarkColors.background;
    return BarTooltipItem("${rod.toY.toInt()}",
        TextStyle(color: color, fontWeight: FontWeight.bold));
  }
}
