class Organization {
  String id;
  String name;
  String operationArea;
  String phoneOne;
  String phoneTwo;
  String address;
  String managerName;
  String managerPhone;
  String managerEmail;

  Organization({
    this.id,
    this.name,
    this.operationArea,
    this.phoneOne,
    this.phoneTwo,
    this.address,
    this.managerName,
    this.managerPhone,
    this.managerEmail,
  });

  Organization.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    operationArea = json['operationArea'];
    phoneOne = json['phoneOne'];
    phoneTwo = json['phoneTwo'];
    address = json['address'];
    managerName = json['managerName'];
    managerPhone = json['managerPhone'];
    managerEmail = json['managerEmail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['operationArea'] = this.operationArea;
    data['phoneOne'] = this.phoneOne;
    data['phoneTwo'] = this.phoneTwo;
    data['address'] = this.address;
    data['managerName'] = this.managerName;
    data['managerPhone'] = this.managerPhone;
    data['managerEmail'] = this.managerEmail;
    return data;
  }
}
