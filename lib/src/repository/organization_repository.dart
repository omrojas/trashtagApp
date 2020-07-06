import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:trashtagApp/src/graphql/graphql_service.dart';
import 'package:trashtagApp/src/graphql/mutations.dart';
import 'package:trashtagApp/src/graphql/queries.dart';
import 'package:trashtagApp/src/models/organization.dart';

class OrganizationRepository {
  final Mutations mutations = Mutations();
  final GraphQLService graphQLService = GraphQLService();
  final Queries queries = Queries();

  Future<List<Organization>> getOrganizations() async {
    try {
      // await Future.delayed(Duration(seconds: 2));
      QueryResult response = await graphQLService.performQuery(
        queries.getOrganizations,
      );

      return _parseOrganizations(response);
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<bool> createOrganizations({
    @required final String name,
    @required final String operationArea,
    @required final String phone1,
    @required final String phone2,
    @required final String address,
    @required final String managerName,
    @required final String managerPhone,
    @required final String managerEmail,
  }) async {
    try {
      // await Future.delayed(Duration(seconds: 2));
      QueryResult response = await graphQLService.performMutation(
        queries.createOrganization,
        variables: {
          'name': name,
          'operationArea': operationArea,
          'phone1': phone1,
          'phone2': phone2,
          'address': address,
          'managerName': managerName,
          'managerPhone': managerPhone,
          'managerEmail': managerEmail,
        },
      );

      return response.data.saved == true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  List<Organization> _parseOrganizations(reponse) {
    return [];
  }
}
