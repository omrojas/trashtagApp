part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {}

class AuthenticationFailure extends AuthenticationState {}

class AuthenticationInProgress extends AuthenticationState {}

class Unauthentication extends AuthenticationState {}

class SignUpAsIndependentVolunteer extends AuthenticationState {}

class SignUpAsOrganizationVolunteer extends AuthenticationState {}

class ViewTerms extends AuthenticationState {}