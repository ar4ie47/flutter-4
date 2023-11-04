// import 'package:anki/component/neumorph_conteiner.dart';
// import 'package:anki/temp/items.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../constant/colors.dart';
// import '../main.dart';
//
// class WordsPage extends StatelessWidget {
//   const WordsPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var items = Data.items;
//     return Scaffold(
//         bottomNavigationBar: const AnkiBottomNavigationBar(),
//         body: SafeArea(
//             child: GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3,
//                     mainAxisSpacing: 20,
//                     crossAxisSpacing: 20),
//                 padding: const EdgeInsets.all(20),
//                 itemCount: items.length,
//                 itemBuilder: (_, index) => NeumorphicContainer(
//                     borderRadius: 12,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Text(textAlign: TextAlign.center, items[index].word),
//                         const Divider(
//                           color: DarkColors.primary,
//                           thickness: 1,
//                           indent: 24,
//                           endIndent: 24,
//                         ),
//                         Text(
//                             textAlign: TextAlign.center, items[index].translate)
//                       ],
//                     )))));
//   }
// }
