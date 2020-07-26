import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:trashtagApp/src/models/organization.dart';

import 'api_respository.dart';

class OrganizationRepository extends ApiRepository {
  OrganizationRepository() : super(authorization: false);
  Future<List<Organization>> getOrganizations() async {
    QueryResult response = await graphQLService.performQuery(
      queries.getOrganizations,
    );

    return _parseOrganizations(response);
  }

  Future<bool> createOrganizations({
    @required final Organization organization,
  }) async {
    QueryResult response = await graphQLService.performMutation(
      mutations.createOrganization,
      variables: {
        'name': organization.name,
        'operationArea': organization.operationArea,
        'phoneOne': organization.phoneOne,
        'phoneTwo': organization.phoneTwo,
        'address': organization.address,
        'managerName': organization.managerName,
        'managerPhone': organization.managerPhone,
        'managerEmail': organization.managerEmail,
      },
    );

    return response.data['createOrganization']['saved'];
  }

  List<Organization> _parseOrganizations(response) {
    final List organizations = response.data['allOrganizations'];
    return organizations.map((e) => Organization.fromJson(e)).toList();
  }
}
