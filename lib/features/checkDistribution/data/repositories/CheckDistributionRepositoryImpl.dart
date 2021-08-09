import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:clean_tdd_flutter/features/checkDistribution/data/datasources/CheckDistributionDataSource.dart';
import 'package:clean_tdd_flutter/features/checkDistribution/data/models/CheckDistributionModel.dart';
import 'package:clean_tdd_flutter/features/checkDistribution/domain/repositories/CheckDistributionRepository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';

typedef Future<CheckDistributionModel> _CheckDistributionData();

class CheckDistributionRepositoryImpl implements CheckDistributionRepository {
  final CheckDistributionDataSource? checkDistributionDataSource;

  CheckDistributionRepositoryImpl({
    @required this.checkDistributionDataSource,
  });

  @override
  Future<Either<Exception, CheckDistributionModel>> getCheckDistributionParam(
      String? lat, long) async {
    return await _getCheckDistribution(() {
      return checkDistributionDataSource!.getCheckDistribution(lat, long);
    });
  }

  Future<Either<Exception, CheckDistributionModel>> _getCheckDistribution(
    _CheckDistributionData getCheckDistributionData,
  ) async {
    try {
      final checkDistributionModel = await getCheckDistributionData();

      return Right(checkDistributionModel);
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
