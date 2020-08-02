import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:trashtagApp/src/models/user_statistics.dart';
import 'package:trashtagApp/src/repository/user_repository.dart';

part 'my_progress_event.dart';
part 'my_progress_state.dart';

class MyProgressBloc extends Bloc<MyProgressEvent, MyProgressState> {
  final UserRepository userRepository;
  MyProgressBloc({@required this.userRepository})
      : assert(userRepository != null),
        super();

  @override
  MyProgressState get initialState => MyProgressInitial();

  @override
  Stream<MyProgressState> mapEventToState(
    MyProgressEvent event,
  ) async* {
    if (event is LoadStatistics) {
      yield LoadingStatistics();
      final errorMessage =
          'Some error has occurred when loading your information.';
      try {
        final userStatistics = await userRepository.getUserStatistics();
        if (userStatistics != null) {
          yield StatisticsLoadsSuccessfully(userStatistics: userStatistics);
        } else {
          yield ErrorLoadingStatistics(error: errorMessage);
        }
      } catch (e) {
        yield ErrorLoadingStatistics(error: errorMessage);
      }
    }
  }
}
