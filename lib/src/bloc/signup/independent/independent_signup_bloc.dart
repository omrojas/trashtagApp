import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:trashtagApp/src/repository/user_repository.dart';

part 'independent_signup_event.dart';
part 'independent_signup_state.dart';

class IndependentSignUpBloc
    extends Bloc<IndependentSignUpEvent, IndependentSignUpState> {
  final UserRepository userRepository;

  IndependentSignUpBloc({
    @required this.userRepository,
  }) : assert(userRepository != null);

  @override
  IndependentSignUpState get initialState => IndependentSignUpInitial();

  @override
  Stream<IndependentSignUpState> mapEventToState(
      IndependentSignUpEvent event) async* {
    if (event is CreateAccountButtonPressed) {
      try {
        yield IndependentSignUpInProgress();

        final response = await userRepository.createIndividualVolunteer(
          fullName: event.name,
          email: event.email,
          password: event.password,
        );

        print('Response: $response');
        if (response == null) {
          // throw ('');
        }

        yield IndependentSignUpSuccess(message: 'User successfully created');
      } catch (e) {
        yield IndependentSignUpFailure(
            error:
                'An error has occurred, check the information or try again later.');
      }
    }
  }
}
