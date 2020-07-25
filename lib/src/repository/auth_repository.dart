import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:trashtagApp/src/models/user.dart';

import 'api_respository.dart';

class AuthRepository extends ApiRepository {
  Future<String> authenticate({
    @required final String username,
    @required final String password,
  }) async {
    QueryResult result = await graphQLService.performMutation(
      mutations.login,
      variables: {
        'userName': username,
        'password': password,
      },
    );

    return result.data["tokenAuth"]['token'];
  }

  Future<void> deleteToken() async {
    await storage.delete(key: 'token');
    return;
  }

  Future<void> persistToken(final String token) async {
    await storage.write(key: 'token', value: token);
    return;
  }

  Future<bool> hasToken() async {
    final token = await storage.read(key: 'token');
    return token != null;
  }

  Future<bool> createIndividualVolunteer({
    @required final User user,
  }) async {
    QueryResult result = await graphQLService.performMutation(
      mutations.createIndividualVolunteer,
      variables: {
        'firstName': user.firstName,
        'lastName': user.lastName,
        'email': user.email,
        'password': user.password,
      },
    );
    return result.data['signUp']['saved'];
  }

  Future<bool> createOrganizerVolunteer({
    @required final User user,
    @required final int organizationId,
  }) async {
    QueryResult result = await graphQLService.performMutation(
      mutations.createOrganizerVolunteer,
      variables: {
        'firstName': user.firstName,
        'lastName': user.lastName,
        'email': user.email,
        'password': user.password,
        'organizationId': organizationId,
      },
    );

    return result.data['signUp']['saved'];
  }
}
