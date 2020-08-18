import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:trashtagApp/src/models/reports/report_data.dart';
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
        final data = await this.repository.getItemsPickOut(event.year);
        yield ItemsPickedUpInYear(year: event.year, data: data);
      } catch (e) {
        print(e);
        yield ItemsPickedUpInYear(year: event.year, data: []);
      }
    }

    if (event is NumberOfVolunteersButtonPressed) {
      yield LoadingReport();
      try {
        final data = await this.repository.getNumberOfVolunteers();
        yield NumberOfVolunteers(data: data);
      } catch (e) {
        print(e);
        yield NumberOfVolunteers(data: []);
      }
    }

    if (event is QuantityOfLitterByItemsButtonPressed) {
      yield LoadingReport();
      try {
        final data = await this.repository.getQuantityOfLitterByItems();
        yield QuantityOfLitterByItems(data: data);
      } catch (e) {
        print(e);
        yield QuantityOfLitterByItems(data: []);
      }
    }

    if (event is BackButtonPressed) {
      yield ReportsInitial();
    }
  }
}
