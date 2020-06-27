part of 'splash_bloc.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();
}

class SplashStarted extends SplashEvent {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'SplashStarted... ';
}

class LoginButtonPressed extends SplashEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoginButtonPressed... ';
}
