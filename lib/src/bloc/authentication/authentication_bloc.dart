import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
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

    if (event is SignUpAsIndependentVolunterrButtonPressed) {
      yield SignUpAsIndependentVolunteer();
    }

    if (event is SignUpAsOrganizationVolunterrButtonPressed) {
      yield SignUpAsOrganizationVolunteer();
    }

    if (event is AuthenticationStarted) {
      try {
        bool validToken = await isValidToken();
        if (validToken) {
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

    if (event is TermsButtonPressed) {
      yield ViewTerms();
    }
  }

  Future<bool> isValidToken() async {
    try {
      final String token = await authRepository.getToken();
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      final exp = decodedToken['exp'];
      final expiration = new DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      final now = new DateTime.now();
      return expiration.isAfter(now);
    } catch (e) {
      return false;
    }
  }
}
