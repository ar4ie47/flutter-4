import 'package:anki/screen/add_card_screen.dart';
import 'package:anki/temp/items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../constant/colors.dart';
import '../neumorph_conteiner.dart';

class CardTitle extends StatelessWidget {
  AnkiCard card;
  SlidableActionCallback? deletePressed;

  CardTitle({Key? key, required this.card, this.deletePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12),
        child: Slidable(
            endActionPane: ActionPane(
                extentRatio: 0.2,
                motion: const StretchMotion(),
                children: [
                  SlidableAction(
                      onPressed: deletePressed,
                      backgroundColor: DarkColors.background,
                      foregroundColor: DarkColors.redIcon,
                      icon: Icons.delete)
                ]),
            child: NeumorphicContainer(
                padding: EdgeInsets.symmetric(horizontal: 12),
                borderRadius: 10,
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 50,
                      child: Text(
                        card.word,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(" | "),
                    Expanded(
                      flex: 50,
                      child: Text(
                        card.translate,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ))));
  }
}
