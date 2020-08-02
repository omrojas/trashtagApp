part of 'my_progress_bloc.dart';

abstract class MyProgressEvent extends Equatable {
  const MyProgressEvent();

  @override
  List<Object> get props => [];
}

class LoadStatistics extends MyProgressEvent {}
