import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:trashtagApp/src/models/organization.dart';
import 'package:trashtagApp/src/models/user.dart';
import 'package:trashtagApp/src/repository/organization_repository.dart';
import 'package:trashtagApp/src/repository/auth_repository.dart';

part 'organizer_signup_event.dart';
part 'organizer_signup_state.dart';

class OrganizerSignUpBloc
    extends Bloc<OrganizerSignUpEvent, OrganizerSignUpState> {
  final AuthRepository authRepository;
  final OrganizationRepository organizationRepository;

  OrganizerSignUpBloc({
    @required final this.authRepository,
    @required final this.organizationRepository,
  }) : assert(authRepository != null, organizationRepository != null);

  @override
  OrganizerSignUpState get initialState => OrganizerSignUpInitial();

  @override
  Stream<OrganizerSignUpState> mapEventToState(
    OrganizerSignUpEvent event,
  ) async* {
    if (event is OrganizerSignUpStarted) {
      yield OrganizerSignUpInitial();
    }

    if (event is LoadOrganizations) {
      try {
        final organizations = await organizationRepository.getOrganizations();
        yield OrganizationsLoaded(organizations: organizations);
      } catch (e) {
        print('error: $e');
        yield OrganizationsLoaded(organizations: []);
      }
    }

    if (event is CreateAccountButtonPressed) {
      final errorMessage =
          'An error has occurred, check the information or try again later.';
      try {
        yield OrganizerSignUpInProgress();

        final response = await authRepository.createOrganizerVolunteer(
          user: event.user,
          organizationId: event.organizationId,
        );

        if (response == true) {
          yield OrganizerSignUpSuccess(message: 'User successfully created');
        }
        yield OrganizerSignUpFailure(error: errorMessage);
      } catch (e) {
        yield OrganizerSignUpFailure(error: errorMessage);
      }
    }

    if (event is CreateOrganizationButtonPressed) {
      yield ViewOrganization();
    }
  }
}
