import 'dart:convert';

import 'package:clean_tdd_flutter/core/util/gpl_query.dart';
import 'package:clean_tdd_flutter/features/login/data/models/LoginModel.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:meta/meta.dart';
import 'package:clean_tdd_flutter/core/constants/EndPointPath.dart';
import 'package:clean_tdd_flutter/core/error/exceptions.dart';

abstract class LoginDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.

  Future<LoginModel> getLogin();
}

class LoginDataSourceImpl implements LoginDataSource {
  final GraphQLClient? client;

  LoginDataSourceImpl({@required this.client});

  @override
  Future<LoginModel> getLogin() =>
      _getTriviaFromUrl(Uri.parse('https://graphqljds.herokuapp.com/graphql'));

  Future<LoginModel> _getTriviaFromUrl(Uri url) async {
    try {
      final result = await client!.query(QueryOptions(
        document: gql(GqlQuery.charactersQuery),
      ));

      return LoginModel.fromJson(result.data!);
    } on Exception catch (exception) {
      print(exception);
      throw ServerExceptions();
    }
  }
}
