class UserStatistics {
  int cleanups;
  int itemsPicked;
  int itemsToNextLevel;

  UserStatistics({this.cleanups, this.itemsPicked, this.itemsToNextLevel});

  UserStatistics.fromJson(Map<String, dynamic> json) {
    cleanups = json['cleanups'];
    itemsPicked = json['itemsPicked'];
    itemsToNextLevel = json['itemsToNextLevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cleanups'] = this.cleanups;
    data['itemsPicked'] = this.itemsPicked;
    data['itemsToNextLevel'] = this.itemsToNextLevel;
    return data;
  }
}
