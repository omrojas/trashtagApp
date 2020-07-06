import 'package:flutter/material.dart';
import 'package:trashtagApp/src/graphql/graphql_service.dart';
import 'package:trashtagApp/src/graphql/mutations.dart';

class ContactRepository {
  final GraphQLService graphQLService = GraphQLService();
  final Mutations mutations = Mutations();

  Future<bool> sendMessage({
    @required final String subject,
    @required final String messaje,
  }) async {
    try {
      final query = '';
      final response = await graphQLService.performMutation(
        query,
        variables: {
          'subject': subject,
          'messaje': messaje,
        },
      );

      return response.data.saved == true;
    } catch (e) {
      return false;
    }
  }
}
