// import 'package:anki/constant/colors.dart';
// import 'package:anki/temp/items.dart';
// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'package:flutter/material.dart';
//
// import '../component/neumorph_conteiner.dart';
//
// class AddCardPage extends StatefulWidget {
//   AddCardPage({super.key});
//
//   @override
//   State<AddCardPage> createState() => _AddCardPageState();
// }
//
// class _AddCardPageState extends State<AddCardPage> {
//   final wordController = TextEditingController();
//   final translateWordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Column(
//       children: [
//         Expanded(
//             flex: 20,
//             child: Center(
//                 child: Text("ANKI",
//                     style: Theme.of(context).textTheme.headlineLarge))),
//         Expanded(
//             flex: 80,
//             child: NeumorphicContainer(
//               margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 80),
//               child: Padding(
//                 padding: const EdgeInsets.all(24),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     TextField(
//                       controller: wordController,
//                       textInputAction: TextInputAction.next,
//                       textAlign: TextAlign.center,
//                       decoration:
//                           const InputDecoration(border: InputBorder.none),
//                     ),
//                     const Divider(
//                       color: DarkColors.primary,
//                       thickness: 1,
//                       indent: 24,
//                       endIndent: 24,
//                     ),
//                     TextField(
//                         controller: translateWordController,
//                         textInputAction: TextInputAction.next,
//                         textAlign: TextAlign.center,
//                         decoration:
//                             const InputDecoration(border: InputBorder.none))
//                   ],
//                 ),
//               ),
//             )),
//         Expanded(
//             flex: 30,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 NeumorphicContainer(
//                   height: 64,
//                   width: 64,
//                   borderRadius: 12,
//                   child: IconButton(
//                     onPressed: () {
//                       var word = wordController.value.text;
//                       var translate = translateWordController.value.text;
//                       var snackBarContent = AwesomeSnackbarContent(
//                           contentType: ContentType.success,
//                           message: "Card is added",
//                           title: 'Success');
//                       if (word.isEmpty ||
//                           translate.isEmpty ||
//                           word.trim().isEmpty ||
//                           translate.trim().isEmpty) {
//                         snackBarContent = AwesomeSnackbarContent(
//                             contentType: ContentType.warning,
//                             message: "Card can't be empty",
//                             title: 'Warn');
//                       } else {
//                         Data.items
//                             .add(AnkiCard(word: word, translate: translate));
//                         wordController.clear();
//                         translateWordController.clear();
//                       }
//
//                       ScaffoldMessenger.of(context)
//                         ..removeCurrentSnackBar()
//                         ..showSnackBar(SnackBar(
//                             content: snackBarContent,
//                             backgroundColor: DarkColors.background));
//                     },
//                     icon: Icon(Icons.add),
//                     color: DarkColors.greenIcon,
//                   ),
//                 ),
//               ],
//             )),
//       ],
//     ));
//   }
// }
