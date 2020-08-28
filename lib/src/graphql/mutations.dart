class Mutations {
  final String login = '''
    mutation tokenAuth(\$userName: String!, \$password: String!) {
      tokenAuth(username: \$userName, password: \$password) {
        token
      }
    }
  ''';

  final String createIndividualVolunteer = '''
    mutation signUp(\$email: String!, \$firstName: String!, \$lastName: String!, \$password: String!){
      signUp(email: \$email, firstName: \$firstName, lastName: \$lastName, password: \$password) {
        saved
      }
    }
  ''';

  final String createOrganizerVolunteer = '''
    mutation signUp(\$email: String!, \$firstName: String!, \$lastName: String!, \$password: String!,  \$organizationId: Int){
      signUp(email: \$email, firstName: \$firstName, lastName: \$lastName, password: \$password, organizationId: \$organizationId) {
        saved
      }
    }
  ''';

  final String createOrganization = '''
    mutation createOrganization(\$name: String!, \$address: String!, \$operationArea: String!, \$phoneOne: String!, \$phoneTwo: String!, \$managerName: String!, \$managerEmail: String!, \$managerPhone: String!) {
      createOrganization(name: \$name, address: \$address, operationArea: \$operationArea, phoneOne: \$phoneOne, phoneTwo: \$phoneTwo, managerName: \$managerName, managerEmail: \$managerEmail, managerPhone: \$managerPhone) {
        saved
      }
    }
  ''';

  final String userMessage = '''
    mutation createUserMessage(\$message: String!, \$subject: String!) {
      createUserMessage(message: \$message, subject: \$subject) {
        saved
      }
    }
  ''';

  final String submitCollect = '''
    mutation cleanup(\$trashes: [TrashQuantity]!, \$latitude: String!, \$longitude: String!) {
      cleanup(trashes: \$trashes, latitude: \$latitude, longitude: \$longitude) {
        saved
      }
    }
  ''';
}
