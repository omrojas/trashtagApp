class PickedUpLitterPerMonth {
  int month;
  int quantity;

  PickedUpLitterPerMonth({this.month, this.quantity});

  PickedUpLitterPerMonth.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['quantity'] = this.quantity;
    return data;
  }
}
