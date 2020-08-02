import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  final String url = 'https://api-trashtag.herokuapp.com/graphql/';
  final secureStorage = new FlutterSecureStorage();
  final bool authorization;

  GraphQLClient _client;

  GraphQLService(this.authorization) {
    final HttpLink httpLink = HttpLink(uri: url);

    final AuthLink authLink = authorization
        ? AuthLink(getToken: () async {
            final token = await secureStorage.read(key: 'token');
            return 'JWT $token';
          })
        : null;

    final policies = Policies(
      fetch: FetchPolicy.networkOnly,
    );

    _client = GraphQLClient(
      link: authorization ? authLink.concat(httpLink) : httpLink,
      cache: InMemoryCache(),
      defaultPolicies: DefaultPolicies(
        watchQuery: policies,
        query: policies,
        mutate: policies,
      ),
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
