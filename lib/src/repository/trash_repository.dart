import 'package:flutter/material.dart';
import 'package:trashtagApp/src/models/coordinate.dart';
import 'package:trashtagApp/src/models/select_trash.dart';
import 'package:trashtagApp/src/models/trash.dart';

import 'api_respository.dart';

class TrashRepository extends ApiRepository {
  Future<List<Trash>> getTrashes() async {
    final response = await graphQLService.performQuery(
      queries.getTrash,
    );
    return _parseTrahes(response);
  }

  Future<bool> submitCollect({
    @required final List<SelectedTrash> selectedTrashes,
    @required final Coordinate coordinate,
  }) async {
    final trashes = selectedTrashes
        .map((e) => {'trashId': e.trash.id, 'quantity': e.quantity})
        .toList();
    // TODO Send coordinate to API
    final response = await graphQLService.performMutation(
      mutations.submitCollect,
      variables: {
        'trashes': trashes,
      },
    );

    return response.data['cleanup']['saved'];
  }

  List<Trash> _parseTrahes(response) {
    final trashes = response.data['allTrashes'] as List;
    return trashes.map((i) => Trash.fromJson(i)).toList();
  }
}
