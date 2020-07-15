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
}
