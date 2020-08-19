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
        iconUrl
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
        nextLevel
        currentLevel
      }
    }
  ''';

  final pickedUpLitterPerMonth = '''
    {
      pickedUpLitterPerMonth{
        month
        quantity
      }
    }
  ''';

  final volunteersNumber = '''
    {
      volunteersNumber
    }
  ''';

  final quantityOfLitterByItems = '''
    {
      quantityOfLitterByItems{
        garbage
        quantity
      }
    }
  ''';
}
