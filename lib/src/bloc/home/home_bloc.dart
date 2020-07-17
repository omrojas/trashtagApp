import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super();

  @override
  HomeState get initialState => HomeView();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is ContactButtonPressed) {
      yield ContactView();
    }

    if (event is HomeButtonPressed) {
      yield HomeView();
    }

    if (event is CollectButtonPressed) {
      yield CollectView();
    }

    if (event is UserListButtonPressed) {
      yield UserListView();
    }
  }
}
