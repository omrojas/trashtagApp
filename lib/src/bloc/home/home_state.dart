part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class ContactView extends HomeState {}

class HomeView extends HomeState {
  final UserInformation userInformation;

  HomeView({@required this.userInformation});

  @override
  List<Object> get props => [userInformation];
}

class CollectView extends HomeState {}

class UserListView extends HomeState {}
