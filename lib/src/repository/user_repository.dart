import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:trashtagApp/src/graphql/graphql_service.dart';
import 'package:trashtagApp/src/graphql/mutations.dart';

class UserRepository {
  final FlutterSecureStorage storage = new FlutterSecureStorage();
  final GraphQLService graphQLService = GraphQLService();
  final Mutations mutations = Mutations();

  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    QueryResult result = await graphQLService.performMutation(
      mutations.login,
      variables: {
        'userName': username,
        'password': password,
      },
    );

    return result.hasException ? null : result.data["tokenAuth"]['token'];
  }

  Future<void> deleteToken() async {
    /// await Future.delayed(Duration(seconds: 1));
    await storage.delete(key: 'token');
    return;
  }

  Future<void> persistToken(String token) async {
    /// await Future.delayed(Duration(seconds: 1));
    await storage.write(key: 'token', value: token);
    return;
  }

  Future<bool> hasToken() async {
    /// await Future.delayed(Duration(seconds: 1));
    final token = await storage.read(key: 'token');
    return token != null;
  }
}
