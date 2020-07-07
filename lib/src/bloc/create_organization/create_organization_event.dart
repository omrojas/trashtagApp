part of 'create_organization_bloc.dart';

abstract class CreateOrganizationEvent extends Equatable {
  const CreateOrganizationEvent();
  @override
  List<Object> get props => throw UnimplementedError();
}

class SubmitButtonPressed extends CreateOrganizationEvent {
  final String name;
  final String area;
  final String phone1;
  final String phone2;
  final String addres;
  final String managerName;
  final String managerPhone;
  final String managerEmail;
  SubmitButtonPressed({
    @required this.name,
    @required this.area,
    @required this.phone1,
    @required this.phone2,
    @required this.addres,
    @required this.managerName,
    @required this.managerPhone,
    @required this.managerEmail,
  });

  @override
  List<Object> get props => [
        name,
        area,
        phone1,
        phone2,
        addres,
        managerName,
        managerPhone,
        managerEmail
      ];

  @override
  String toString() => 'SubmitButtonPressed';
}
