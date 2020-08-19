class QuantityOfLitterPickedUp {
  String garbage;
  int quantity;

  QuantityOfLitterPickedUp({this.garbage, this.quantity});

  QuantityOfLitterPickedUp.fromJson(Map<String, dynamic> json) {
    garbage = json['garbage'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['garbage'] = this.garbage;
    data['quantity'] = this.quantity;
    return data;
  }
}
