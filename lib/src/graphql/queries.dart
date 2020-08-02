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
        id
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

  final getUserStatistics = '''
    {
      userStatistics{
        cleanups
        itemsPicked
        itemsToNextLevel
      }
    }
  ''';
}
