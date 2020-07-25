import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashtagApp/src/models/user_information.dart';

import 'api_respository.dart';

class UserRepository extends ApiRepository {
  final String userKey = 'userInformation';

  UserRepository() : super();

  Future<UserInformation> getUserInformation() async {
    try {
      final localUser = await _getLocalUserInformation();
      if (localUser == null) {
        final user = await _getUserInformationFromAPI();
        await saveUserInformation(userInformation: user);
        return user;
      }
      return localUser;
    } catch (e) {
      return null;
    }
  }

  Future<void> saveUserInformation({
    @required final UserInformation userInformation,
  }) async {
    try {
      final preferences = await SharedPreferences.getInstance();
      final String value = json.encode(userInformation.toJson());
      await preferences.setString(userKey, value);
    } catch (e) {}
  }

  Future<UserInformation> _getLocalUserInformation() async {
    try {
      final preferences = await SharedPreferences.getInstance();
      final data = preferences.get(userKey);
      final Map<String, dynamic> userData = json.decode(data);
      return UserInformation.fromJson(userData);
    } catch (e) {
      return null;
    }
  }

  Future<UserInformation> _getUserInformationFromAPI() async {
    QueryResult response = await graphQLService.performQuery(
      queries.getUserInformation,
    );

    final Map<String, dynamic> user = response.data['$userKey'];
    return UserInformation.fromJson(user);
  }
}
