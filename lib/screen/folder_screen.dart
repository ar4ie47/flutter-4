import 'package:anki/component/neumorph_icon.dart';
import 'package:anki/model/folder.dart';
import 'package:anki/viewmodel/folder_view_model.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../component/folder/folder_tile.dart';
import '../constant/colors.dart';
import '../repository/card_repository.dart';
import '../utils/showMessage.dart';
import 'learning_screen.dart';

class FolderPage extends StatelessWidget {
  static const String route = '/folder';

  FolderPage({super.key});

  final _repository = CardRepository.db;

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
                        deletePressed: (action) => read.delete(folder.id!),
                        playPressed: () => playPressed(context, folder.id!));
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

  void playPressed(BuildContext context, int folderId) async {
    var listQueue = await _repository.getQueue(folderId);
    if (listQueue.isEmpty) {
      showMessage(context, ContentType.help, "There are no cards in the folder",
          "Info");
    } else {
      Navigator.pushNamed(context, LearningPage.route, arguments: listQueue);
    }
  }

  AppBar getAppBar(BuildContext context) {
    return AppBar(
        backgroundColor: DarkColors.background,
        title: Center(
            child: Text("ANKI",
                style: Theme.of(context).textTheme.headlineLarge)));
  }
}
