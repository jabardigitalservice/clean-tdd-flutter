import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:clean_tdd_flutter/features/checkDistribution/data/models/CheckDistributionModel.dart';
import 'package:clean_tdd_flutter/features/checkDistribution/domain/repositories/CheckDistributionRepository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class GetCheckDistribution implements UseCase<CheckDistributionModel, Params> {
  final CheckDistributionRepository repository;

  GetCheckDistribution(this.repository);

  @override
  Future<Either<Exception, CheckDistributionModel>> call(Params params) async {
    return await repository.getCheckDistributionParam(params.lat, params.long);
  }
}

class Params extends Equatable {
  final String? lat, long;

  Params({@required this.lat, @required this.long});

  @override
  List<Object?> get props => [lat, long];
}
