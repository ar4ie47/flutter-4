import 'package:anki/temp/items.dart';
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
  @override
  Widget build(BuildContext context) {
    var folders = FolderItem.getFolders();
    return Scaffold(
      appBar: getAppBar(context),
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(height: 24),
          Expanded(
              flex: 80,
              child: ListView.builder(
                  itemCount: folders.length,
                  itemBuilder: (context, index) {
                    var folder = folders[index];
                    return FolderTile(
                        text: folder,
                        isReadOnly: folder.isEmpty ? false : true,
                        deletePressed: (action) =>
                            setState(() => FolderItem.remove(folder)));
                  })),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NeumorphicIcon(
                    icon: Icons.add,
                    iconColor: DarkColors.greenIcon,
                    onPressed: addFolderTile)
              ],
            ),
          ),
        ],
      )),
    );
  }

  void addFolderTile() {
    setState(() {
      FolderItem.add("", List.empty());
    });
  }

  AppBar getAppBar(BuildContext context) {
    return AppBar(
        backgroundColor: DarkColors.background,
        title: Center(
            child: Text("ANKI",
                style: Theme.of(context).textTheme.headlineLarge)));
  }
}
