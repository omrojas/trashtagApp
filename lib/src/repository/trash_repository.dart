import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trashtagApp/src/models/trash.dart';

import 'api_respository.dart';

class TrashRepository extends ApiRepository {
  Future<bool> createTrash({
    @required final Trash trash,
  }) async {
    final response = await graphQLService.performMutation(
      mutations.createTrash,
    );
    return response.data['createTrash']['saved'];
  }

  Future<List<Trash>> getTrashes() async {
    final response = await graphQLService.performQuery(
      queries.getTrash,
    );
    return _parseTrahes(response);
  }

  List<Trash> _parseTrahes(response) {
    final parsed = json.decode(response.data);
    final trashes = parsed['allTrashes'] as List;
    if (trashes == null) {
      return [];
    }
    return trashes.map((i) => Trash.fromJson(i)).toList();
  }
}
