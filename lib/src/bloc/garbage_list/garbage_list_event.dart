part of 'garbage_list_bloc.dart';

abstract class GarbageListEvent extends Equatable {
  const GarbageListEvent();

  @override
  List<Object> get props => [];
}

class SetGarbageList extends GarbageListEvent {
  final List<SelectedTrash> trashes;

  SetGarbageList({@required this.trashes});

  @override
  List<Object> get props => [trashes];
}

class SubmitList extends GarbageListEvent {}
