part of 'organizer_signup_bloc.dart';

abstract class OrganizerSignUpState extends Equatable {
  const OrganizerSignUpState();

  @override
  List<Object> get props => [];
}

class OrganizerSignUpInitial extends OrganizerSignUpState {}

class OrganizationsLoaded extends OrganizerSignUpState {
  final List<Organization> organizations;

  OrganizationsLoaded({@required final this.organizations});

  @override
  List<Object> get props => [];
}

class OrganizerSignUpInProgress extends OrganizerSignUpState {}

class OrganizerSignUpSuccess extends OrganizerSignUpState {
  final String message;

  OrganizerSignUpSuccess({@required this.message});

  @override
  List<Object> get props => [message];
}

class OrganizerSignUpFailure extends OrganizerSignUpState {
  final String error;

  const OrganizerSignUpFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'IndependentSignUpFailure { error: $error }';
}

class ViewOrganization extends OrganizerSignUpState {}
