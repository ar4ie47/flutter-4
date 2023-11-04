import 'package:anki/temp/items.dart';
import 'package:anki/utils/dialog_box.dart';
import 'package:anki/utils/neumorph_icon.dart';
import 'package:flutter/material.dart';

import '../component/folder/folder_tile.dart';
import '../constant/colors.dart';

class FolderPage extends StatefulWidget {
  const FolderPage({super.key});

  @override
  State<FolderPage> createState() => _FolderPageState();
}

class _FolderPageState extends State<FolderPage> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var folders = FolderItem.getFolders();
    return Scaffold(
      appBar: AppBar(
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
                  itemCount: folders.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FolderTile(
                        isReadOnly: true,
                        text: folders[index],
                        deletePressed: (context) {
                          setState(() {
                            FolderItem.remove(folders[index]);
                          });
                        });
                  })),
          Expanded(
              flex: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NeumorphicIcon(
                      icon: const Icon(Icons.add),
                      iconColor: DarkColors.greenIcon,
                      onPressed: () => createOrEditFolder(context))
                ],
              )),
        ],
      )),
    );
  }

  void createOrEditFolder(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
              controller: _textController,
              onSave: () => saveFolder(context),
              onCancel: () => cancel(context));
        });
  }

  void cancel(BuildContext context) {
    Navigator.of(context).pop();
    _textController.clear();
  }

  void saveFolder(BuildContext context) {
    setState(() {
      FolderItem.add(_textController.text, List.empty());
    });
    cancel(context);
  }
}
