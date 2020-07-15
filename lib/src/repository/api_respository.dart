import 'package:trashtagApp/src/graphql/graphql_service.dart';
import 'package:trashtagApp/src/graphql/mutations.dart';
import 'package:trashtagApp/src/graphql/queries.dart';

class ApiRepository {
  final GraphQLService graphQLService = GraphQLService();
  final Mutations mutations = Mutations();
  final Queries queries = Queries();
}
