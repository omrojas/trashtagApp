import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:trashtagApp/src/models/reports/report_data.dart';
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

  Future<List<ReportData>> getItemsPickOut(final int year) async {
    // TODO CALL API
    return _tempData();
  }

  Future<List<ReportData>> getNumberOfVolunteers() async {
    // TODO CALL API
    return _tempData();
  }

  Future<List<ReportData>> getQuantityOfLitterByItems() async {
    // TODO CALL API
    return _tempData();
  }

  List<ReportData> _tempData() {
    return [
      new ReportData(1, 40),
      new ReportData(2, 60),
      new ReportData(3, 20),
      new ReportData(4, 70),
      new ReportData(5, 70),
      new ReportData(6, 70),
      new ReportData(7, 70),
      new ReportData(8, 70),
    ];
  }
}
