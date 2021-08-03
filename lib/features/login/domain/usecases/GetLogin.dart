import 'package:clean_tdd_flutter/features/login/data/models/LoginModel.dart';
import 'package:clean_tdd_flutter/features/login/domain/repositories/LoginRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class GetLogin implements UseCase<LoginModel, Params> {
  final LoginRepository repository;

  GetLogin(this.repository);

  @override
  Future<Either<Failure, LoginModel>> call(Params params) async {
    return await repository.getLoginParam(params.email, params.password);
  }
}

class Params extends Equatable {
  final String? email, password;

  Params({@required this.email, @required this.password});

  @override
  List<Object?> get props => [email, password];
}
