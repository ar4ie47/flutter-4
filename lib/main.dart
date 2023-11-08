import 'dart:collection';

import 'package:anki/screen/card_screen.dart';
import 'package:anki/screen/folder_screen.dart';
import 'package:anki/screen/learning_screen.dart';
import 'package:anki/utils/theme.dart';
import 'package:anki/viewmodel/card_view_model.dart';
import 'package:anki/viewmodel/folder_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: _getRoute,
      theme: darkTheme(),
      home: MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => FolderViewModel()),
      ], child: FolderPage()),
    );
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name == CardPage.route) {
      // FooRoute constructor expects SomeObject
      return _buildRoute(
          settings,
          ChangeNotifierProvider(
              builder: (context, child) =>
                  CardPage(folderId: settings.arguments as int),
              create: (_) => CardViewModel()));
    } else if (settings.name == LearningPage.route) {
      return _buildRoute(settings,
          LearningPage(queueCards: settings.arguments as ListQueue<CardModel>));
    }
    return _buildRoute(
        settings,
        ChangeNotifierProvider(
            builder: (context, child) => FolderPage(),
            create: (_) => FolderViewModel()));
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(
      settings: settings,
      builder: (ctx) => builder,
    );
  }
}
