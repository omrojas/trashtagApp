part of 'contact_bloc.dart';

abstract class ContactState extends Equatable {
  const ContactState();
  @override
  List<Object> get props => [];
}

class ContactInitial extends ContactState {}

class SendingMessage extends ContactState {}

class SendMessageSuccess extends ContactState {}

class SendMessageFailed extends ContactState {
  final String error;

  SendMessageFailed({@required final this.error});

  @override
  List<Object> get props => [error];
}
