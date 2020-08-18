part of 'reports_bloc.dart';

abstract class ReportsEvent extends Equatable {
  const ReportsEvent();

  @override
  List<Object> get props => [];
}

class ItemsPickedUpInYearButtonPressed extends ReportsEvent {
  final int year;

  ItemsPickedUpInYearButtonPressed({@required this.year});

  @override
  List<Object> get props => [year];
}

class NumberOfVolunteersButtonPressed extends ReportsEvent {}

class QuantityOfLitterByItemsButtonPressed extends ReportsEvent {}

class BackButtonPressed extends ReportsEvent {}
