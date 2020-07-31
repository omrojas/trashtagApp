part of 'garbage_list_bloc.dart';

abstract class GarbageListState extends Equatable {
  const GarbageListState();

  @override
  List<Object> get props => [];
}

class GarbageList extends GarbageListState {
  final List<SelectedTrash> trashes;

  GarbageList({@required this.trashes});

  @override
  List<Object> get props => [trashes];
}

class SendingCollect extends GarbageListState {}

class SuccessfulSend extends GarbageListState {
  final String message;

  SuccessfulSend({@required this.message});

  @override
  List<Object> get props => [message];
}

class SendError extends GarbageListState {
  final String error;

  SendError({@required this.error});

  @override
  List<Object> get props => [error];
}
