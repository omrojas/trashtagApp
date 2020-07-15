part of 'independent_signup_bloc.dart';

abstract class IndependentSignUpEvent extends Equatable {
  @override
  List<Object> get props => [];
  const IndependentSignUpEvent();
}

class CreateAccountButtonPressed extends IndependentSignUpEvent {
  final User user;

  CreateAccountButtonPressed({@required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'CreateAccountButtonPressed { user: $user }';
}

class LoginButtonPressed extends IndependentSignUpEvent {
  @override
  String toString() => 'LoginButtonPressed';
}
