import 'package:anki/model/folder.dart';
import 'package:flutter/material.dart';

import '../repository/folder_repository.dart';

class FolderViewModel extends ChangeNotifier {
  var _folders = <FolderModel>[];

  List<FolderModel> get folders => _folders;

  FolderViewModel() {
    loadItems();
  }

  void loadItems() async {
    _folders = await FolderRepository.db.getAll();
    notifyListeners();
  }

  void update(FolderModel folder) async {
    FolderRepository.db.update(folder);
    _folders = await FolderRepository.db.getAll();
    notifyListeners();
  }

  Future<FolderModel> create(FolderModel folder) async {
    var createEntity = await FolderRepository.db.insert(folder);
    _folders = await FolderRepository.db.getAll();
    notifyListeners();
    return createEntity;
  }

  void delete(int id) async {
    FolderRepository.db.delete(id);
    _folders = await FolderRepository.db.getAll();
    notifyListeners();
  }

  void deleteByName(String folderName) async {
    FolderRepository.db.deleteByName(folderName);
    _folders = await FolderRepository.db.getAll();
    notifyListeners();
  }

  void deleteTable() async {
    FolderRepository.db.deleteDatabase();
  }
}
