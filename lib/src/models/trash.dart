class Trash {
  String id;
  String name;
  String imageUrl;
  String iconUrl;

  Trash({this.id, this.name, this.imageUrl, this.iconUrl});

  Trash.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    iconUrl = json['iconUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    data['iconUrl'] = this.iconUrl;
    return data;
  }
}
