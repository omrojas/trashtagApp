part of 'collect_bloc.dart';

abstract class CollectState extends Equatable {
  const CollectState();

  @override
  List<Object> get props => [];
}

class CollectInitial extends CollectState {}

class LoadingTrashes extends CollectState {}

class LoadTrashesSuccess extends CollectState {
  final List<Trash> trashes;

  LoadTrashesSuccess({@required this.trashes});

  @override
  List<Object> get props => [trashes];
}

class LoadTrashesFailure extends CollectState {
  final String error;

  LoadTrashesFailure({@required this.error});

  @override
  List<Object> get props => [error];
}
