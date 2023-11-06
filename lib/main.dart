import 'package:anki/screen/folder_screen.dart';
import 'package:anki/utils/theme.dart';
import 'package:flutter/material.dart';

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
      home: const Scaffold(body: FolderPage()),
      // routes: {"/words": (BuildContext context) => const WordsPage()}
    );
  }
}
