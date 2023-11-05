import 'dart:collection';

import 'package:anki/constant/colors.dart';
import 'package:anki/temp/items.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';

import '../component/neumorph_conteiner.dart';
import 'end_learning_page.dart';
import 'folder_screen.dart';

class LearningPage extends StatefulWidget {
  ListQueue<AnkiCard> queueCards;

  LearningPage({super.key, required this.queueCards});

  @override
  State<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  final _flipController = FlipCardController();
  final _learningCards = <LearningCard>[];
  var _cards = ListQueue();

  @override
  void initState() {
    super.initState();
    if (_cards.isEmpty && _learningCards.isEmpty) {
      _cards = ListQueue.of(widget.queueCards);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FolderPage()),
                      (Route<dynamic> route) => false);
                },
                icon: Icon(Icons.arrow_back_rounded)),
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
        body: _cards.isNotEmpty
            ? SafeArea(
                child: Column(
                children: [
                  Expanded(
                      flex: 70,
                      child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 80, horizontal: 80),
                          child: FlipCard(
                            controller: _flipController,
                            front: NeumorphicContainer(
                              child: Center(child: Text(_cards.first.word)),
                            ),
                            back: NeumorphicContainer(
                                child: Center(
                                    child: Text(_cards.first.translate))),
                          ))),
                  Expanded(
                      flex: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          NeumorphicContainer(
                            height: 64,
                            width: 64,
                            borderRadius: 12,
                            child: IconButton(
                              onPressed: () {
                                addAndPush(context, false);
                              },
                              icon: const Icon(Icons.close),
                              color: DarkColors.redIcon,
                            ),
                          ),
                          NeumorphicContainer(
                            height: 64,
                            width: 64,
                            borderRadius: 12,
                            child: IconButton(
                                onPressed: () {
                                  addAndPush(context, true);
                                },
                                icon: const Icon(Icons.navigate_next,
                                    color: DarkColors.greenIcon)),
                          ),
                        ],
                      )),
                ],
              ))
            : const SafeArea(child: SizedBox()));
  }

  void addAndPush(BuildContext context, bool isSucces) {
    flipIfBack();
    setState(() {
      var card = _cards.removeFirst();
      _learningCards.add(LearningCard(
          word: card.word, translate: card.translate, isSuccess: isSucces));
      if (_cards.isEmpty) {
        push(context, _learningCards);
      }
    });
  }

  void flipIfBack() {
    if (!_flipController.state!.isFront) {
      _flipController.toggleCardWithoutAnimation();
    }
  }

  void push(BuildContext context, List<LearningCard> cards) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => LearningCompletedPage(cards: cards)),
        (Route<dynamic> route) => false);
  }
}

class LearningCard {
  String word;
  String translate;
  bool isSuccess;

  LearningCard(
      {required this.word, required this.translate, required this.isSuccess});
}
