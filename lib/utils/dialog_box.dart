import 'package:anki/constant/colors.dart';
import 'package:flutter/material.dart';

import 'button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox(
      {Key? key,
      required this.controller,
      required this.onSave,
      required this.onCancel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: DarkColors.background,
        content: SizedBox(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                autofocus: true,
                onSubmitted: (context) => onSave.call(),
                controller: controller,
                decoration: const InputDecoration(
                    hintText: "Folder name", border: OutlineInputBorder()),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(onPressed: onSave, text: "Save"),
                  const SizedBox(width: 8),
                  CustomButton(onPressed: onCancel, text: "Cancel"),
                ],
              )
            ],
          ),
        ));
  }
}
