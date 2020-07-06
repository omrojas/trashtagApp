part of 'independent_signup_bloc.dart';

abstract class IndependentSignUpState extends Equatable {
  const IndependentSignUpState();

  @override
  List<Object> get props => [];
}

class IndependentSignUpInitial extends IndependentSignUpState {}

class IndependentSignUpInProgress extends IndependentSignUpState {}

class IndependentSignUpSuccess extends IndependentSignUpState {
  final String message;

  IndependentSignUpSuccess({@required this.message});

  @override
  List<Object> get props => [message];
}

class IndependentSignUpFailure extends IndependentSignUpState {
  final String error;

  const IndependentSignUpFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'IndependentSignUpFailure { error: $error }';
}
