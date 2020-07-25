import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:trashtagApp/src/models/user_information.dart';
import 'package:trashtagApp/src/repository/user_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository userRepository;
  HomeBloc({@required this.userRepository})
      : assert(userRepository != null),
        super();

  @override
  HomeState get initialState => HomeInitial();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is ContactButtonPressed) {
      yield ContactView();
    }

    if (event is HomeButtonPressed) {
      final user = await userRepository.getUserInformation();
      yield HomeView(userInformation: user);
    }

    if (event is CollectButtonPressed) {
      yield CollectView();
    }

    if (event is UserListButtonPressed) {
      yield UserListView();
    }
  }
}
