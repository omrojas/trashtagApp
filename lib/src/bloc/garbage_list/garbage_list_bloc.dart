import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:trashtagApp/src/models/select_trash.dart';
import 'package:trashtagApp/src/repository/trash_repository.dart';

part 'garbage_list_event.dart';
part 'garbage_list_state.dart';

class GarbageListBloc extends Bloc<GarbageListEvent, GarbageListState> {
  final TrashRepository repository;
  final List<SelectedTrash> _trashes = [];

  GarbageListBloc({@required this.repository}) : assert(repository != null);

  @override
  GarbageListState get initialState => GarbageList(trashes: _trashes);

  @override
  Stream<GarbageListState> mapEventToState(
    GarbageListEvent event,
  ) async* {
    if (event is SetGarbageList) {
      _trashes.clear();
      _trashes.addAll(event.trashes);
      yield GarbageList(trashes: _trashes);
    }

    if (event is SubmitList) {
      yield SendingCollect();
      final errorMessage = 'We had a problem trying to save your items.';

      try {
        final status = await repository.submitCollect(
          selectedTrashes: _trashes,
        );
        if (status) {
          final succesfulMessage =
              'Your list has been submitted for approvall. We will check your work in order to create an official TrashTag report with it';
          _trashes.clear();
          yield SuccessfulSend(message: succesfulMessage);
        } else {
          yield SendError(error: errorMessage);
        }
      } catch (e) {
        print(e);
        yield SendError(error: errorMessage);
      }
    }
  }
}
