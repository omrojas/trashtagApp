part of 'collect_bloc.dart';

abstract class CollectEvent extends Equatable {
  const CollectEvent();

  @override
  List<Object> get props => [];
}

class LoadTrashes extends CollectEvent {}

class IncrementTrash extends CollectEvent {
  final Trash trash;

  IncrementTrash(this.trash);

  @override
  List<Object> get props => [trash];
}

class DecrementTrash extends CollectEvent {
  final Trash trash;

  DecrementTrash(this.trash);

  @override
  List<Object> get props => [trash];
}
