import 'package:anki/component/neumorph_icon.dart';
import 'package:anki/model/folder.dart';
import 'package:anki/viewmodel/folder_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../component/folder/folder_tile.dart';
import '../constant/colors.dart';

class FolderPage extends StatelessWidget {
  const FolderPage({super.key});

  @override
  Widget build(BuildContext context) {
    var folders = context.watch<FolderViewModel>().folders;
    var read = context.read<FolderViewModel>();
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
                    var folderName = folder.folderName ?? "";
                    return FolderTile(
                        folderModel: folder,
                        isReadOnly: folderName.isEmpty ? false : true,
                        deletePressed: (action) => read.delete(folder.id!));
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
                    onPressed: () {
                      read.create(FolderModel(folderName: ""));
                      // read.deleteTable();
                    })
              ],
            ),
          ),
        ],
      )),
    );
  }

  AppBar getAppBar(BuildContext context) {
    return AppBar(
        backgroundColor: DarkColors.background,
        title: Center(
            child: Text("ANKI",
                style: Theme.of(context).textTheme.headlineLarge)));
  }
}
