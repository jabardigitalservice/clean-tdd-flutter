import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:clean_tdd_flutter/core/constants/EndPointPath.dart';
import 'package:clean_tdd_flutter/core/error/exceptions.dart';
import 'package:clean_tdd_flutter/features/checkDistribution/data/models/CheckDistributionModel.dart';

abstract class CheckDistributionDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<CheckDistributionModel> getCheckDistribution(String? number, long);
}

class CheckDistributionDataSourceImpl implements CheckDistributionDataSource {
  final http.Client? client;

  CheckDistributionDataSourceImpl({@required this.client});

  @override
  Future<CheckDistributionModel> getCheckDistribution(String? lat, long) =>
      _getTriviaFromUrl(
          Uri.parse('${EndPointPath.checkDistribution}?long=$long&lat=$lat'));

  Future<CheckDistributionModel> _getTriviaFromUrl(Uri url) async {
    final response = await client!.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return CheckDistributionModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
