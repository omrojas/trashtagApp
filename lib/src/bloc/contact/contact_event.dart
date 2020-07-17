part of 'contact_bloc.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();
}

class SendMessageButtonPressed extends ContactEvent {
  final UserMessage message;

  SendMessageButtonPressed({
    @required final this.message,
  });

  @override
  List<Object> get props => [message];
}
