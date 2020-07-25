import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:trashtagApp/src/models/organization.dart';
import 'package:trashtagApp/src/repository/organization_repository.dart';

part 'create_organization_event.dart';
part 'create_organization_state.dart';

class CreateOrganizationBloc
    extends Bloc<CreateOrganizationEvent, CreateOrganizationState> {
  final OrganizationRepository repository;

  CreateOrganizationBloc({@required this.repository})
      : assert(repository != null);

  @override
  CreateOrganizationState get initialState => CreateOrganizationInitial();

  @override
  Stream<CreateOrganizationState> mapEventToState(
    CreateOrganizationEvent event,
  ) async* {
    if (event is SubmitButtonPressed) {
      try {
        yield SubmitInProgress();

        final organization = event.organization;
        final response = await repository.createOrganizations(
          organization: organization,
        );

        if (response == false) {
          throw ('');
        }

        yield SubmitSuccess(
            message:
                'Thanks for joining us! A member of Trashtag will get in contact for verification.');
      } catch (e) {
        yield SubmitFailure(
            error:
                'An error has occurred, check the information or try again later.');
      }
    }
  }
}
