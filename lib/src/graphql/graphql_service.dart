import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  final storage = new FlutterSecureStorage();
  final String url = 'https://api-trashtag.herokuapp.com/graphql/';

  GraphQLClient _client;

  GraphQLService() {
    final HttpLink httpLink = HttpLink(uri: url);
    final AuthLink authLink = AuthLink(getToken: () async {
      final token = await storage.read(key: 'token');
      return 'JWT $token';
    });

    _client = GraphQLClient(
      link: authLink.concat(httpLink),
      cache: InMemoryCache(),
    );
  }

  Future<QueryResult> performQuery(
    String query, {
    Map<String, dynamic> variables,
  }) async {
    QueryOptions options = QueryOptions(
      documentNode: gql(query),
      variables: variables,
    );

    return await _client.query(options);
  }

  Future<QueryResult> performMutation(
    String query, {
    Map<String, dynamic> variables,
  }) async {
    MutationOptions options = MutationOptions(
      documentNode: gql(query),
      variables: variables,
    );

    return await _client.mutate(options);
  }
}
