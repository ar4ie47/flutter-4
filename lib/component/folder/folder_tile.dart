import 'package:anki/component/card_page.dart';
import 'package:anki/temp/items.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../constant/colors.dart';
import '../../screen/learning_page.dart';
import '../neumorph_conteiner.dart';

class FolderTile extends StatefulWidget {
  String text;
  SlidableActionCallback? deletePressed;
  bool isReadOnly = true;

  FolderTile(
      {Key? key,
      required this.text,
      this.deletePressed,
      required this.isReadOnly})
      : super(key: key);

  @override
  State<FolderTile> createState() => _FolderTileState();
}

class _FolderTileState extends State<FolderTile> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12),
        child: Slidable(
          endActionPane: ActionPane(
              extentRatio: 0.4,
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                    onPressed: (context) {
                      setState(() {
                        widget.isReadOnly = false;
                      });
                    },
                    backgroundColor: DarkColors.background,
                    foregroundColor: DarkColors.greenIcon,
                    icon: Icons.edit),
                SlidableAction(
                    onPressed: widget.deletePressed,
                    backgroundColor: DarkColors.background,
                    foregroundColor: DarkColors.redIcon,
                    icon: Icons.delete)
              ]),
          child: NeumorphicContainer(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              borderRadius: 10,
              height: 60,
              child: Center(
                  child: widget.isReadOnly
                      ? ListTile(
                          contentPadding: EdgeInsets.zero,
                          trailing: IconButton(
                              onPressed: () {
                                if (FolderItem.getCards(widget.text).isEmpty) {
                                  ScaffoldMessenger.of(context)
                                    ..removeCurrentSnackBar()
                                    ..showSnackBar(SnackBar(
                                        content: AwesomeSnackbarContent(
                                            contentType: ContentType.help,
                                            message:
                                                "There are no cards in the folder",
                                            title: 'Info'),
                                        backgroundColor:
                                            DarkColors.background));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LearningPage(
                                              folderName: widget.text)));
                                }
                              },
                              icon: const Icon(Icons.play_arrow,
                                  color: DarkColors.greenIcon)),
                          title: Text(
                            widget.text,
                            textAlign: TextAlign.start,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CardsPage(folderName: widget.text)),
                            );
                          },
                        )
                      : TextField(
                          autofocus: true,
                          textAlign: TextAlign.start,
                          controller: _textController,
                          onEditingComplete: () {
                            var newText = _textController.text;
                            var text = widget.text;
                            var cards = FolderItem.getCards(text);
                            FolderItem.remove(text);
                            FolderItem.add(newText, cards);
                            setState(() {
                              widget.isReadOnly = true;
                              widget.text = newText;
                            });
                          },
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                          readOnly: widget.isReadOnly))),
        ));
  }
}
