import 'package:trashtagApp/src/models/trash.dart';

class SelectedTrash {
  Trash trash;
  int quantity;

  SelectedTrash({this.trash, this.quantity});

  SelectedTrash.fromJson(Map<String, dynamic> json) {
    trash = json['trash'] != null ? new Trash.fromJson(json['trash']) : null;
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.trash != null) {
      data['trash'] = this.trash.toJson();
    }
    data['quantity'] = this.quantity;
    return data;
  }
}
