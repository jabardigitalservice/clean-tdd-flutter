import 'dart:convert';

import 'package:clean_tdd_flutter/core/util/gpl_query.dart';
import 'package:clean_tdd_flutter/features/login/data/models/LoginModel.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:meta/meta.dart';
import 'package:clean_tdd_flutter/core/constants/EndPointPath.dart';
import 'package:clean_tdd_flutter/core/error/exceptions.dart';

abstract class LoginDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.

  Future<LoginModel> getLogin(String? email, password);
}

class LoginDataSourceImpl implements LoginDataSource {
  final GraphQLClient? client;

  LoginDataSourceImpl({@required this.client});

  @override
  Future<LoginModel> getLogin(String? email, password) =>
      _getTriviaFromUrl(email, password);

  Future<LoginModel> _getTriviaFromUrl(String? email, password) async {
    final result = await client!.query(QueryOptions(
        document: gql(GqlQuery.loginQuery),
        variables: {"email": email, "password": password}));
    print(result.data);
    if (result.exception != null) {
      print('masuk exeption');
      throw Exception(result.exception.toString());
    } else {
      return LoginModel.fromJson(result.data!);
    }
  }
}
