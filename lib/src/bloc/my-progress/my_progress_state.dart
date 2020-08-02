part of 'my_progress_bloc.dart';

abstract class MyProgressState extends Equatable {
  const MyProgressState();

  @override
  List<Object> get props => [];
}

class MyProgressInitial extends MyProgressState {}

class LoadingStatistics extends MyProgressState {}

class StatisticsLoadsSuccessfully extends MyProgressState {
  final UserStatistics userStatistics;

  StatisticsLoadsSuccessfully({@required this.userStatistics});

  @override
  List<Object> get props => [userStatistics];
}

class ErrorLoadingStatistics extends MyProgressState {
  final String error;

  ErrorLoadingStatistics({@required this.error});

  @override
  List<Object> get props => [error];
}
