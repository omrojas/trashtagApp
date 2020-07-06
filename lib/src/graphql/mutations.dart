class Mutations {
  final String login = '''
    mutation tokenAuth(\$userName: String!, \$password: String!) {
      tokenAuth(username: \$userName, password: \$password) {
        token
      }
    }
  ''';

  final String createIndividualVolunteer = '''
  ''';

  final String createOrganizerVolunteer = '''
  ''';
}
