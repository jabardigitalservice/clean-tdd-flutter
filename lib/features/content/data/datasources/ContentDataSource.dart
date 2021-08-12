import 'package:clean_tdd_flutter/core/util/gpl_query.dart';
import 'package:clean_tdd_flutter/features/content/data/models/ContentModel.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:meta/meta.dart';

abstract class ContentDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.

  Future<ContentModel> getContent(int? page);
}

class ContentDataSourceImpl implements ContentDataSource {
  final GraphQLClient? client;

  ContentDataSourceImpl({@required this.client});

  @override
  Future<ContentModel> getContent(int? page) => _getTriviaFromUrl(page);

  Future<ContentModel> _getTriviaFromUrl(
    int? page,
  ) async {
    final result = await client!
        .query(QueryOptions(document: gql(GqlQuery.postQuery), variables: {
      "page": page,
    }));
    print(result.data);
    if (result.exception != null) {
      print('masuk exeption');
      throw Exception(result.exception.toString());
    } else {
      return ContentModel.fromJson(result.data!);
    }
  }
}
