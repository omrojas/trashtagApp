part of 'independent_signup_bloc.dart';

abstract class IndependentSignUpEvent extends Equatable {
  @override
  List<Object> get props => [];
  const IndependentSignUpEvent();
}

class CreateAccountButtonPressed extends IndependentSignUpEvent {
  final String name;
  final String email;
  final String password;

  CreateAccountButtonPressed({
    @required this.name,
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [name, email, password];

  @override
  String toString() =>
      'CreateAccountButtonPressed { name: $name, email: $email, password: $password }';
}

class LoginButtonPressed extends IndependentSignUpEvent {
  @override
  String toString() => 'LoginButtonPressed';
}
