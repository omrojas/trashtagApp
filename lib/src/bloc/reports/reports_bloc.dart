import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:trashtagApp/src/models/reports/picked_up_litter_per_month.dart';
import 'package:trashtagApp/src/models/reports/quantity_of_litter_picked_up.dart';
import 'package:trashtagApp/src/repository/statistics_repository.dart';

part 'reports_event.dart';
part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  final StatisticsRepository repository;
  ReportsBloc({@required this.repository})
      : assert(repository != null),
        super();

  @override
  ReportsState get initialState => ReportsInitial();

  @override
  Stream<ReportsState> mapEventToState(
    ReportsEvent event,
  ) async* {
    if (event is ItemsPickedUpInYearButtonPressed) {
      yield LoadingReport();
      try {
        final data = await this.repository.getPickedUpLitterPerMonth();
        yield ItemsPickedUpInYear(year: event.year, data: data);
      } catch (e) {
        yield ItemsPickedUpInYear(year: event.year, data: []);
      }
    }

    if (event is NumberOfVolunteersButtonPressed) {
      yield LoadingReport();
      try {
        final volunteers = await this.repository.getNumberOfVolunteers();
        yield NumberOfVolunteers(volunteers: volunteers);
      } catch (e) {
        yield NumberOfVolunteers(volunteers: 0);
      }
    }

    if (event is QuantityOfLitterByItemsButtonPressed) {
      yield LoadingReport();
      try {
        final data = await this.repository.getQuantityOfLitterByItems();
        yield QuantityOfLitterByItems(data: data);
      } catch (e) {
        yield QuantityOfLitterByItems(data: []);
      }
    }

    if (event is BackButtonPressed) {
      yield ReportsInitial();
    }
  }
}
