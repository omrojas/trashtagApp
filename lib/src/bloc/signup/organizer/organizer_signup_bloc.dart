import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:trashtagApp/src/repository/user_repository.dart';

part 'organizer_signup_event.dart';
part 'organizer_signup_state.dart';

class OrganizerSignUpBloc
    extends Bloc<OrganizerSignUpEvent, OrganizerSignUpState> {
  final UserRepository userRepository;

  OrganizerSignUpBloc({
    @required this.userRepository,
  }) : assert(userRepository != null);

  @override
  OrganizerSignUpState get initialState => OrganizerSignUpInitial();

  @override
  Stream<OrganizerSignUpState> mapEventToState(
    OrganizerSignUpEvent event,
  ) async* {
    if (event is CreateAccountButtonPressed) {
      try {
        yield OrganizerSignUpInProgress();

        final response = await userRepository.createOrganizerVolunteer(
          email: event.email,
          fullName: event.name,
          password: event.password,
          organizationId: event.organizationId,
        );

        print('Response: $response');
        if (response == null) {
          // throw ('');
        }

        yield OrganizerSignUpSuccess(message: 'User successfully created');
      } catch (e) {
        yield OrganizerSignUpFailure(
            error:
                'An error has occurred, check the information or try again later.');
      }
    }

    if (event is CreateOrganizationButtonPressed) {
      yield ViewOrganization();
    }
  }
}
