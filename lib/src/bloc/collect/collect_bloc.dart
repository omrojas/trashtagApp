import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:trashtagApp/src/models/trash.dart';
import 'package:trashtagApp/src/repository/trash_repository.dart';

part 'collect_event.dart';
part 'collect_state.dart';

class CollectBloc extends Bloc<CollectEvent, CollectState> {
  final TrashRepository repository;

  CollectBloc({@required this.repository})
      : assert(repository != null),
        super();

  @override
  CollectState get initialState => CollectInitial();

  @override
  Stream<CollectState> mapEventToState(
    CollectEvent event,
  ) async* {
    if (event is LoadTrashes) {
      yield LoadingTrashes();
      final errorMessage = 'Error loading garbage categories';
      try {
        final List<Trash> trashes = await repository.getTrashes();
        if (trashes != null) {
          yield LoadTrashesSuccess(trashes: trashes);
        } else {
          yield LoadTrashesFailure(error: errorMessage);
        }
      } catch (e) {
        yield LoadTrashesFailure(error: errorMessage);
      }
    }
  }
}
