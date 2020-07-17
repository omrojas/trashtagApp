import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:trashtagApp/src/models/user_message.dart';
import 'package:trashtagApp/src/repository/contact_repository.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository repository;
  ContactBloc({@required this.repository})
      : assert(repository != null),
        super();

  @override
  ContactState get initialState => ContactInitial();

  @override
  Stream<ContactState> mapEventToState(
    ContactEvent event,
  ) async* {
    if (event is SendMessageButtonPressed) {
      final errorMessage = 'We could not receive your message';

      try {
        yield SendingMessage();

        final saved = await repository.sendMessage(
          message: event.message,
        );

        if (saved == true) {
          yield SendMessageSuccess();
        } else {
          yield SendMessageFailed(error: errorMessage);
        }
      } catch (e) {
        yield SendMessageFailed(error: errorMessage);
      }
    }
  }
}
