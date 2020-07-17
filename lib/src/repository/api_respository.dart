import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:trashtagApp/src/graphql/graphql_service.dart';
import 'package:trashtagApp/src/graphql/mutations.dart';
import 'package:trashtagApp/src/graphql/queries.dart';

class ApiRepository {
  final FlutterSecureStorage storage = new FlutterSecureStorage();
  final Mutations mutations = Mutations();
  final Queries queries = Queries();
  GraphQLService graphQLService;

  ApiRepository() {
    final token = storage.read(key: 'token');

    token
        .then((value) => graphQLService = GraphQLService(value))
        .catchError((error) => graphQLService = GraphQLService(null));
  }
}
