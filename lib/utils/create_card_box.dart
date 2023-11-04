import 'package:anki/utils/button.dart';
import 'package:flutter/material.dart';

import '../component/neumorph_conteiner.dart';
import '../constant/colors.dart';

class AddCardBox extends StatelessWidget {
  final wordController;
  final translateController;
  VoidCallback onSave;
  VoidCallback onCancel;

  AddCardBox(
      {Key? key,
      required this.wordController,
      required this.translateController,
      required this.onSave,
      required this.onCancel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: DarkColors.background,
        content: SizedBox(
          height: MediaQuery.of(context).size.width / 1,
          child: Column(
            children: [
              Expanded(
                flex: 70,
                child: NeumorphicContainer(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextField(
                      autofocus: true,
                      controller: wordController,
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.center,
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                    ),
                    const Divider(
                      color: DarkColors.primary,
                      thickness: 1,
                      indent: 24,
                      endIndent: 24,
                    ),
                    TextField(
                        controller: translateController,
                        textInputAction: TextInputAction.next,
                        textAlign: TextAlign.center,
                        decoration:
                            const InputDecoration(border: InputBorder.none))
                  ],
                )),
              ),
              Expanded(
                  flex: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(onPressed: onSave, text: "Add"),
                      CustomButton(onPressed: onCancel, text: "Cancel"),
                    ],
                  ))
            ],
          ),
        )
        // )
        );
  }
}
