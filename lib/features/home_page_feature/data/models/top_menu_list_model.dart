class TopMenuListModel {
  String? icon;
  String? label;

  TopMenuListModel({this.icon, this.label});

  TopMenuListModel.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['label'] = this.label;
    return data;
  }
}
