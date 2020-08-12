import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:trashtagApp/src/repository/auth_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository authRepository;

  AuthenticationBloc({@required this.authRepository})
      : assert(authRepository != null);

  @override
  AuthenticationState get initialState => AuthenticationInitial();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield Unauthentication();
    }

    if (event is SignUpAsIndependentVolunterrButtonPresed) {
      yield SignUpAsIndependentVolunteer();
    }

    if (event is SignUpAsOrganizationVolunterrButtonPresed) {
      yield SignUpAsOrganizationVolunteer();
    }

    if (event is AuthenticationStarted) {
      try {
        final bool hasToken = await authRepository.hasToken();
        if (hasToken) {
          yield AuthenticationSuccess();
        } else {
          yield AuthenticationInitial();
        }
      } catch (e) {
        yield AuthenticationInitial();
      }
    }

    if (event is AuthenticationLoggedIn) {
      yield AuthenticationInProgress();
      await authRepository.persistToken(event.token);
      yield AuthenticationSuccess();
    }

    if (event is AuthenticationLoggedOut) {
      yield AuthenticationInProgress();
      await authRepository.deleteToken();
      yield AuthenticationInitial();
    }
  }
}
