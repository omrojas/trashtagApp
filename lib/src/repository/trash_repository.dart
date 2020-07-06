import 'package:flutter/material.dart';
import 'package:trashtagApp/src/graphql/graphql_service.dart';
import 'package:trashtagApp/src/graphql/mutations.dart';
import 'package:trashtagApp/src/models/trash.dart';

class TrashRepository {
  final GraphQLService graphQLService = GraphQLService();
  final Mutations mutations = Mutations();

  Future<bool> createTrash({
    @required final String name,
    @required final String img,
  }) async {
    try {
      final query = mutations.createIndividualVolunteer;
      final response = await graphQLService.performMutation(query);
      return response.data.saved == true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Trash>> getTrashes() async {
    try {
      final query = '';
      final response = await graphQLService.performQuery(query);
      return _parseTrahes(response.data);
    } catch (e) {
      return [];
    }
  }

  List<Trash> _parseTrahes(dynamic data) {
    return [];
  }
}
