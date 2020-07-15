part of 'organizer_signup_bloc.dart';

abstract class OrganizerSignUpEvent extends Equatable {
  @override
  List<Object> get props => [];

  const OrganizerSignUpEvent();
}

class OrganizerSignUpStarted extends OrganizerSignUpEvent {}

class LoadOrganizations extends OrganizerSignUpEvent {}

class CreateAccountButtonPressed extends OrganizerSignUpEvent {
  final User user;
  final int organizationId;

  CreateAccountButtonPressed({
    @required this.user,
    @required this.organizationId,
  });

  @override
  List<Object> get props => [user, organizationId];

  @override
  String toString() => 'CreateAccountButtonPressed';
}

class LoginButtonPressed extends OrganizerSignUpEvent {
  @override
  String toString() => 'LoginButtonPressed';
}

class CreateOrganizationButtonPressed extends OrganizerSignUpEvent {
  @override
  String toString() => 'CreateOrganizationButtonPressed';
}
