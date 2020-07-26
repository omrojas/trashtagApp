import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:trashtagApp/src/graphql/graphql_service.dart';
import 'package:trashtagApp/src/graphql/mutations.dart';
import 'package:trashtagApp/src/graphql/queries.dart';

class ApiRepository {
  final FlutterSecureStorage storage = FlutterSecureStorage();
  final Mutations mutations = Mutations();
  final Queries queries = Queries();
  final bool authorization;

  GraphQLService graphQLService;

  ApiRepository({this.authorization = true}) {
    graphQLService = GraphQLService(authorization);
  }
}
