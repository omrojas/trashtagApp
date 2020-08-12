class UserStatistics {
  int cleanups;
  int itemsPicked;
  int itemsToNextLevel;
  String nextLevel;
  String currentLevel;

  UserStatistics({
    this.cleanups,
    this.itemsPicked,
    this.itemsToNextLevel,
    this.nextLevel,
    this.currentLevel,
  });

  UserStatistics.fromJson(Map<String, dynamic> json) {
    cleanups = json['cleanups'];
    itemsPicked = json['itemsPicked'];
    itemsToNextLevel = json['itemsToNextLevel'];
    nextLevel = json['nextLevel'];
    currentLevel = json['currentLevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cleanups'] = this.cleanups;
    data['itemsPicked'] = this.itemsPicked;
    data['itemsToNextLevel'] = this.itemsToNextLevel;
    data['nextLevel'] = this.nextLevel;
    data['currentLevel'] = this.currentLevel;
    return data;
  }
}
