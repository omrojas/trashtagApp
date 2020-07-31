import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:trashtagApp/src/models/select_trash.dart';
import 'package:trashtagApp/src/models/trash.dart';
import 'package:trashtagApp/src/repository/trash_repository.dart';

part 'collect_event.dart';
part 'collect_state.dart';

class CollectBloc extends Bloc<CollectEvent, CollectState> {
  final TrashRepository repository;
  final Map<String, SelectedTrash> _selectedTrashes = new Map();

  CollectBloc({@required this.repository})
      : assert(repository != null),
        super();

  @override
  CollectState get initialState => CollectInitial();

  @override
  Stream<CollectState> mapEventToState(
    CollectEvent event,
  ) async* {
    if (event is ResetCounters) {
      _selectedTrashes.clear();
    }

    if (event is LoadTrashes || event is ResetCounters) {
      yield LoadingTrashes();
      final String errorMessage = 'Error loading garbage categories';
      try {
        await _loadTrashes();
        yield LoadTrashesSuccess(trashes: _selectedTrashes.values.toList());
      } catch (e) {
        yield LoadTrashesFailure(error: errorMessage);
      }
    }

    if (event is IncrementTrash) {
      _incrementCounter(event.trash);
      yield LoadTrashesSuccess(trashes: _selectedTrashes.values.toList());
    }

    if (event is DecrementTrash) {
      _decrementCounter(event.trash);
      yield LoadTrashesSuccess(trashes: _selectedTrashes.values.toList());
    }
  }

  Future<void> _loadTrashes() async {
    if (_selectedTrashes.isEmpty) {
      final List<Trash> trashes = await repository.getTrashes();
      trashes.forEach((trash) {
        final selectedTrash = SelectedTrash(trash: trash, quantity: 0);
        _selectedTrashes.putIfAbsent(trash.id, () => selectedTrash);
      });
    }
  }

  void _incrementCounter(final Trash trash) {
    _updateCounter(trash, true);
  }

  void _decrementCounter(final Trash trash) {
    _updateCounter(trash, false);
  }

  void _updateCounter(final Trash trash, final bool increment) {
    try {
      final selected = _selectedTrashes[trash.id];
      if (increment) {
        selected.quantity++;
      } else {
        if (selected.quantity > 0) {
          selected.quantity--;
        }
      }
      _selectedTrashes.putIfAbsent(trash.id, () => selected);
    } catch (e) {}
  }
}
