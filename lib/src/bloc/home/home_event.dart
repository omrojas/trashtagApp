part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class ContactButtonPressed extends HomeEvent {}

class HomeButtonPressed extends HomeEvent {}

class CollectButtonPressed extends HomeEvent {}

class UserListButtonPressed extends HomeEvent {}
