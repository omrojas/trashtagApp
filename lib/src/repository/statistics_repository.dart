import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:trashtagApp/src/models/user_statistics.dart';

import 'api_respository.dart';

class StatisticsRepository extends ApiRepository {
  StatisticsRepository() : super();

  Future<UserStatistics> getUserStatistics() async {
    QueryResult response = await graphQLService.performQuery(
      queries.getUserStatistics,
    );
    final Map<String, dynamic> userStatistics = response.data['userStatistics'];
    return UserStatistics.fromJson(userStatistics);
  }
}
