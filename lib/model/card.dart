class CardModel {
  int? id;
  String word = "";
  String translate = "";
  int folderId = 0;

  CardModel(
      {this.id,
      required this.word,
      required this.translate,
      required this.folderId});

  CardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    word = json['word'];
    translate = json['translate'];
    folderId = json['folderId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['word'] = word;
    data['translate'] = translate;
    data['folderId'] = folderId;
    return data;
  }
}
