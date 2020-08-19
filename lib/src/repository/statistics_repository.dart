import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:trashtagApp/src/models/reports/picked_up_litter_per_month.dart';
import 'package:trashtagApp/src/models/reports/quantity_of_litter_picked_up.dart';
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

  Future<List<PickedUpLitterPerMonth>> getPickedUpLitterPerMonth() async {
    QueryResult response = await graphQLService.performQuery(
      queries.pickedUpLitterPerMonth,
    );

    final litters = response.data['pickedUpLitterPerMonth'] as List;
    return litters.map((i) => PickedUpLitterPerMonth.fromJson(i)).toList();
  }

  Future<int> getNumberOfVolunteers() async {
    QueryResult response = await graphQLService.performQuery(
      queries.volunteersNumber,
    );
    return response.data['volunteersNumber'];
  }

  Future<List<QuantityOfLitterPickedUp>> getQuantityOfLitterByItems() async {
    QueryResult response = await graphQLService.performQuery(
      queries.quantityOfLitterByItems,
    );

    final items = response.data['quantityOfLitterByItems'] as List;
    return items.map((i) => QuantityOfLitterPickedUp.fromJson(i)).toList();
  }
}
