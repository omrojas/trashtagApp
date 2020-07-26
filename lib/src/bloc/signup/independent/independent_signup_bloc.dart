import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:trashtagApp/src/models/user.dart';
import 'package:trashtagApp/src/repository/auth_repository.dart';

part 'independent_signup_event.dart';
part 'independent_signup_state.dart';

class IndependentSignUpBloc
    extends Bloc<IndependentSignUpEvent, IndependentSignUpState> {
  final AuthRepository authRepository;

  IndependentSignUpBloc({
    @required this.authRepository,
  }) : assert(authRepository != null);

  @override
  IndependentSignUpState get initialState => IndependentSignUpInitial();

  @override
  Stream<IndependentSignUpState> mapEventToState(
      IndependentSignUpEvent event) async* {
    if (event is CreateAccountButtonPressed) {
      final errorMessage =
          'An error has occurred, check the information or try again later.';
      try {
        yield IndependentSignUpInProgress();

        final response =
            await authRepository.createIndividualVolunteer(user: event.user);

        if (response == true) {
          yield IndependentSignUpSuccess(message: 'User successfully created');
        }

        yield IndependentSignUpFailure(error: errorMessage);
      } catch (e) {
        yield IndependentSignUpFailure(error: errorMessage);
      }
    }
  }
}
