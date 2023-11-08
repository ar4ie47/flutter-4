import 'package:anki/model/folder.dart';
import 'package:anki/screen/card_screen.dart';
import 'package:anki/utils/showMessage.dart';
import 'package:anki/viewmodel/card_view_model.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../constant/colors.dart';
import '../../viewmodel/folder_view_model.dart';
import '../neumorph_conteiner.dart';

class FolderTile extends StatefulWidget {
  FolderModel folderModel;
  SlidableActionCallback? deletePressed;
  VoidCallback? playPressed;
  bool isReadOnly;

  FolderTile(
      {Key? key,
      required this.folderModel,
      this.deletePressed,
      isReadOnly,
      this.playPressed})
      : isReadOnly = isReadOnly ?? true;

  @override
  State<FolderTile> createState() => _FolderTileState();
}

class _FolderTileState extends State<FolderTile> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var read = context.read<FolderViewModel>();

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
                          contentPadding: const EdgeInsets.only(left: 4),
                          trailing: IconButton(
                              onPressed: widget.playPressed,
                              icon: const Icon(Icons.play_arrow,
                                  color: DarkColors.greenIcon)),
                          title: Text(
                            widget.folderModel.folderName ?? "",
                            textAlign: TextAlign.start,
                          ),
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => ChangeNotifierProvider(
                            //             builder: (context, child) => CardPage(
                            //                 folderId: widget.folderModel.id!),
                            //             create: (_) => CardViewModel(),
                            //           )),
                            // );
                            Navigator.pushNamed(context, CardPage.route,
                                arguments: widget.folderModel.id!);
                          },
                        )
                      : TextField(
                          autofocus: true,
                          textAlign: TextAlign.start,
                          controller: _textController,
                          onEditingComplete: () {
                            var newFolderName = _textController.text;
                            var isHasFolder = read.folders.any((element) =>
                                element.folderName == newFolderName);

                            if (newFolderName.isEmpty) {
                              showMessage(context, ContentType.failure,
                                  "The folder name cannot be empty", "Error");
                            } else if (isHasFolder) {
                              showMessage(
                                  context,
                                  ContentType.failure,
                                  "A folder with the same name already exists",
                                  "Error");
                            } else {
                              var folderModel = widget.folderModel;
                              folderModel.folderName = newFolderName;
                              read.update(folderModel);
                              setState(() {
                                widget.isReadOnly = true;
                                widget.folderModel = folderModel;
                              });
                            }
                          },
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 4)),
                          readOnly: widget.isReadOnly))),
        ));
  }
}
