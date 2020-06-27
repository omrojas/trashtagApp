part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {
  const SplashState();
}

class SplashInitial extends SplashState {
  @override
  List<Object> get props => [];
}

class LoginTransition extends SplashState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'SplashTransition...';
}

class RegisterTransition extends SplashState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'RegisterTransition...';
}
