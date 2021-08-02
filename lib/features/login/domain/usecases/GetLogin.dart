import 'package:clean_tdd_flutter/features/login/data/models/LoginModel.dart';
import 'package:clean_tdd_flutter/features/login/domain/repositories/LoginRepository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class GetLogin implements UseCase<LoginModel, NoParams> {
  final LoginRepository repository;

  GetLogin(this.repository);

  @override
  Future<Either<Failure, LoginModel>> call(NoParams noParams) async {
    return await repository.getLoginParam();
  }
}
