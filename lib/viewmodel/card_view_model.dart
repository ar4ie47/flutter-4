import 'package:flutter/material.dart';

import '../model/card.dart';
import '../repository/card_repository.dart';

class CardViewModel extends ChangeNotifier {
  var _cards = <CardModel>[];

  List<CardModel> get cards => _cards;

  CardViewModel() {
    loadItems();
  }

  void loadItems() async {
    _cards = await CardRepository.db.getAll();
    notifyListeners();
  }

  List<CardModel> getCards(int folderId) {
    var list = cards.where((element) => element.folderId == folderId).toList();
    list.shuffle();
    return list;
  }

  void update(CardModel card) async {
    CardRepository.db.update(card);
    _cards = await CardRepository.db.getAll();
    notifyListeners();
  }

  Future<CardModel> create(CardModel card) async {
    var createEntity = await CardRepository.db.insert(card);
    _cards = await CardRepository.db.getAll();
    notifyListeners();
    return createEntity;
  }

  void delete(int id) async {
    CardRepository.db.delete(id);
    _cards = await CardRepository.db.getAll();
    notifyListeners();
  }

  void deleteTable() async {
    CardRepository.db.deleteDatabase();
  }
}
