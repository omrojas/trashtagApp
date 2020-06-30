class Mutations {
  final String login = '''
      mutation tokenAuth(\$userName: String!, \$password: String!) {
        tokenAuth(username: \$userName, password: \$password) {
          token
        }
      }
    ''';
}
