import 'package:flutter/material.dart';
import 'package:trashtagApp/src/models/user_message.dart';

import 'api_respository.dart';

class ContactRepository extends ApiRepository {
  Future<bool> sendMessage({
    @required final UserMessage message,
  }) async {
    final response = await graphQLService.performMutation(
      mutations.userMessage,
      variables: {
        'subject': message.subject,
        'message': message.message,
      },
    );

    return response.data['createUserMessage']['saved'];
  }
}
