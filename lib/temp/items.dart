import 'dart:collection';

class AnkiCard {
  String word;
  String translate;

  AnkiCard({required this.word, required this.translate});
}

class FolderItem {
  static var map = <String, List<AnkiCard>>{};

  static List<String> getFolders() {
    return map.keys.toList();
  }

  static void add(String folderName, List<AnkiCard> cards) {
    map[folderName] = cards;
  }

  static List<AnkiCard> getCards(String folderName) {
    return map[folderName] ?? List.empty(growable: true);
  }

  static ListQueue<AnkiCard> getQueue(String folderName) {
    var cards = map[folderName];
    cards?.shuffle();
    return cards == null ? ListQueue() : ListQueue.of(cards);
  }

  static void remove(String folderName) {
    map.remove(folderName);
  }
}
