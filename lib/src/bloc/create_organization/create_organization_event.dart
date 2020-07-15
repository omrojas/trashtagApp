part of 'create_organization_bloc.dart';

abstract class CreateOrganizationEvent extends Equatable {
  const CreateOrganizationEvent();
}

class SubmitButtonPressed extends CreateOrganizationEvent {
  final Organization organization;

  SubmitButtonPressed({@required final this.organization});

  @override
  List<Object> get props => [organization];

  @override
  String toString() => 'SubmitButtonPressed';
}
