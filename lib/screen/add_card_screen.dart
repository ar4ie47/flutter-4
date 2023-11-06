import 'package:anki/temp/items.dart';
import 'package:anki/utils/create_card_box.dart';
import 'package:flutter/material.dart';

import '../constant/colors.dart';
import '../utils/neumorph_icon.dart';
import '../component/card/card_title.dart';

class CardsPage extends StatefulWidget {
  String folderName;

  CardsPage({Key? key, required this.folderName}) : super(key: key);

  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  final _wordController = TextEditingController();
  final _translateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cards = List.of(FolderItem.getCards(widget.folderName), growable: true);
    return Scaffold(
        appBar: AppBar(
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
            child: Column(
          children: [
            const SizedBox(height: 24),
            Expanded(
              flex: 80,
              child: ListView.builder(
                  itemCount: cards.length,
                  itemBuilder: (context, index) {
                    var card = cards[index];
                    return CardTitle(
                        card: card,
                        deletePressed: (c) {
                          setState(() {
                            cards.removeAt(index);
                            FolderItem.add(widget.folderName, cards);
                          });
                        });
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NeumorphicIcon(
                      icon: Icons.add,
                      iconColor: DarkColors.greenIcon,
                      onPressed: () {
                        createCard(context);
                      })
                ],
              ),
            )
          ],
        )));
  }

  void createCard(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AddCardBox(
            wordController: _wordController,
            translateController: _translateController,
            onCancel: () => cancel(context),
            onSave: () => saveCard(context),
          );
        });
  }

  void cancel(BuildContext context) {
    Navigator.of(context).pop();
    _wordController.clear();
    _translateController.clear();
  }

  void saveCard(BuildContext context) {
    setState(() {
      var cards = List.of(FolderItem.getCards(widget.folderName));
      cards.add(AnkiCard(
          word: _wordController.text, translate: _translateController.text));
      FolderItem.add(widget.folderName, cards);
    });
    cancel(context);
  }
}
