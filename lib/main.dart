import 'package:anki/screen/folder_screen.dart';
import 'package:anki/utils/theme.dart';
import 'package:anki/viewmodel/folder_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      home: MultiProvider(
          providers: [ChangeNotifierProvider(create: (_) => FolderViewModel())],
          child: const FolderPage()),
    );
  }
}
