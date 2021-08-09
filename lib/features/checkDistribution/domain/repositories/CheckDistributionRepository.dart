import 'package:dartz/dartz.dart';
import 'package:clean_tdd_flutter/features/checkDistribution/data/models/CheckDistributionModel.dart';

import '../../../../core/error/failures.dart';

abstract class CheckDistributionRepository {
  Future<Either<Exception, CheckDistributionModel>> getCheckDistributionParam(
      String? lat, long);
}
