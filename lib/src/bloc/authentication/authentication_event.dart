part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStarted extends AuthenticationEvent {}

class AuthenticationLoggedIn extends AuthenticationEvent {
  final String token;

  const AuthenticationLoggedIn({@required this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'AuthenticationLoggedIn { token: $token }';
}

class AuthenticationLoggedOut extends AuthenticationEvent {}

class LoginButtonPressed extends AuthenticationEvent {}

class SignUpAsIndependentVolunterrButtonPressed extends AuthenticationEvent {}

class SignUpAsOrganizationVolunterrButtonPressed extends AuthenticationEvent {}

class TermsButtonPressed extends AuthenticationEvent {}
