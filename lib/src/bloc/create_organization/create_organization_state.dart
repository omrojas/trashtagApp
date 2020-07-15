part of 'create_organization_bloc.dart';

abstract class CreateOrganizationState extends Equatable {
  const CreateOrganizationState();

  @override
  List<Object> get props => [];
}

class CreateOrganizationInitial extends CreateOrganizationState {}

class SubmitInProgress extends CreateOrganizationState {}

class SubmitSuccess extends CreateOrganizationState {
  final String message;

  SubmitSuccess({@required this.message});

  @override
  List<Object> get props => [message];
}

class SubmitFailure extends CreateOrganizationState {
  final String error;

  SubmitFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SubmitFailure { error: $error }';
}
