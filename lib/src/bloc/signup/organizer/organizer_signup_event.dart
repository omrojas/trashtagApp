part of 'organizer_signup_bloc.dart';

abstract class OrganizerSignUpEvent extends Equatable {
  @override
  List<Object> get props => [];

  const OrganizerSignUpEvent();
}

class OrganizerSignUpStarted extends OrganizerSignUpEvent {}

class CreateAccountButtonPressed extends OrganizerSignUpEvent {
  final String name;
  final String email;
  final int organizationId;
  final String password;

  CreateAccountButtonPressed({
    @required this.name,
    @required this.email,
    @required this.organizationId,
    @required this.password,
  });

  @override
  List<Object> get props => [name, email, organizationId, password];

  @override
  String toString() =>
      'CreateAccountButtonPressed { name: $name, email: $email, organization:$organizationId, password: $password }';
}

class LoginButtonPressed extends OrganizerSignUpEvent {
  @override
  String toString() => 'LoginButtonPressed';
}

class CreateOrganizationButtonPressed extends OrganizerSignUpEvent {
  @override
  String toString() => 'CreateOrganizationButtonPressed';
}
