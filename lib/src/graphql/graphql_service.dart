import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  GraphQLClient _client;

  GraphQLService() {
    HttpLink link =
        HttpLink(uri: 'https://api-trashtag.herokuapp.com/graphql/');

    _client = GraphQLClient(
      link: link,
      cache: InMemoryCache(),
      // cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
    );
  }

  Future<QueryResult> performQuery(String query,
      {Map<String, dynamic> variables}) async {
    QueryOptions options = QueryOptions(
      documentNode: gql(query),
      variables: variables,
    );

    return await _client.query(options);
  }

  Future<QueryResult> performMutation(String query,
      {Map<String, dynamic> variables}) async {
    MutationOptions options =
        MutationOptions(documentNode: gql(query), variables: variables);

    final result = await _client.mutate(options);

    print(result);

    return result;
  }
}
