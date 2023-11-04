import 'package:anki/screen/folder_screen.dart';
import 'package:anki/utils/theme.dart';
import 'package:flutter/material.dart';

import 'constant/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darkTheme(),
      home: const AnkiBottomNavigationBar(),
      // routes: {"/words": (BuildContext context) => const WordsPage()}
    );
  }
}

class AnkiBottomNavigationBar extends StatefulWidget {
  const AnkiBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<AnkiBottomNavigationBar> createState() =>
      _AnkiBottomNavigationBarState();
}

class _AnkiBottomNavigationBarState extends State<AnkiBottomNavigationBar> {
  final _tabs = [
    const FolderPage(), const FolderPage()
    // , AddCardPage(), LeaningPage(), AddCardPage()
  ];
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _tabs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
              // BottomNavigationBarItem(
              //     icon: Icon(Icons.search), label: "search"),
              // BottomNavigationBarItem(
              //     icon: Icon(Icons.favorite), label: "favorite"),
              // BottomNavigationBarItem(
              //     icon: Icon(Icons.settings), label: "settings")
            ],
            selectedItemColor: DarkColors.primary,
            onTap: (int index) => setState(() => _currentIndex = index)));
  }
}
