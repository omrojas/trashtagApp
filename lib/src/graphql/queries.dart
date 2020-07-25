class Queries {
  final getOrganizations = '''
    {
      allOrganizations {
        id
        name
      }
    }
  ''';

  final getTrash = '''
    {
      allTrashes {
        name
        imageUrl
      }
    }
  ''';

  final getUserInformation = '''
    {
      userInformation {
        firstName
        lastName
      }
    }
  ''';
}
