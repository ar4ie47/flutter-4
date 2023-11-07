import 'package:anki/component/card/create_card_box.dart';
import 'package:anki/viewmodel/card_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../component/card/card_title.dart';
import '../component/neumorph_icon.dart';
import '../constant/colors.dart';
import '../model/card.dart';

class CardPage extends StatelessWidget {
  int folderId;

  CardPage({Key? key, required this.folderId}) : super(key: key);

  final _wordController = TextEditingController();
  final _translateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => CardViewModel(),
        builder: (context, child) {
          var cards = context.watch<CardViewModel>().getCards(folderId);
          var read = context.read<CardViewModel>();
          return Scaffold(
              appBar: getAppBar(context),
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
                              deletePressed: (c) => read.delete(card.id!));
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
                            onPressed: () => createCard(context, read))
                      ],
                    ),
                  )
                ],
              )));
        });
  }

  AppBar getAppBar(BuildContext context) {
    return AppBar(
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
                style: Theme.of(context).textTheme.headlineLarge)));
  }

  void createCard(BuildContext context, CardViewModel model) {
    showDialog(
        context: context,
        builder: (context) {
          return AddCardBox(
            wordController: _wordController,
            translateController: _translateController,
            onCancel: () => cancel(context),
            onSave: () => saveCard(context, model),
          );
        });
  }

  void cancel(BuildContext context) {
    Navigator.of(context).pop();
    _wordController.clear();
    _translateController.clear();
  }

  void saveCard(BuildContext context, CardViewModel model) {
    model.create(CardModel(
        word: _wordController.text,
        translate: _translateController.text,
        folderId: folderId));
    cancel(context);
  }
}
