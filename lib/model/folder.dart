class FolderModel {
  int? id;
  String? folderName = "";

  FolderModel({this.id, this.folderName});

  FolderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    folderName = json['folderName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['folderName'] = folderName;
    return data;
  }
}
