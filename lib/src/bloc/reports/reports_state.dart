part of 'reports_bloc.dart';

abstract class ReportsState extends Equatable {
  const ReportsState();

  @override
  List<Object> get props => [];
}

class ReportsInitial extends ReportsState {}

class LoadingReport extends ReportsState {}

class ItemsPickedUpInYear extends ReportsState {
  final int year;
  final List<ReportData> data;

  ItemsPickedUpInYear({@required this.year, @required this.data});

  @override
  List<Object> get props => [year, data];
}

class NumberOfVolunteers extends ReportsState {
  final List<ReportData> data;

  NumberOfVolunteers({@required this.data});

  @override
  List<Object> get props => [data];
}

class QuantityOfLitterByItems extends ReportsState {
  final List<ReportData> data;

  QuantityOfLitterByItems({@required this.data});

  @override
  List<Object> get props => [data];
}
