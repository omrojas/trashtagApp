import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  final String url = 'https://api-trashtag.herokuapp.com/graphql/';
  final String token;
  GraphQLClient _client;

  GraphQLService(this.token) {
    final HttpLink httpLink = HttpLink(uri: url);
    final AuthLink authLink = AuthLink(getToken: () => 'JWT $token');

    _client = GraphQLClient(
      link: token != null ? authLink.concat(httpLink) : httpLink,
      cache: InMemoryCache(),
      // cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
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
