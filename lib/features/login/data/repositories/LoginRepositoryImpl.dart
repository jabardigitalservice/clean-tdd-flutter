import 'package:clean_tdd_flutter/features/login/data/datasources/LoginDataSource.dart';
import 'package:clean_tdd_flutter/features/login/data/models/LoginModel.dart';
import 'package:clean_tdd_flutter/features/login/domain/repositories/LoginRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import '../../../../core/error/failures.dart';

typedef Future<LoginModel> _LoginData();

class LoginRepositoryImpl implements LoginRepository {
  final LoginDataSource? loginDataSource;

  LoginRepositoryImpl({
    @required this.loginDataSource,
  });

  @override
  Future<Either<Failure, LoginModel>> getLoginParam() async {
    return await _getLogin(() {
      return loginDataSource!.getLogin();
    });
  }

  Future<Either<Failure, LoginModel>> _getLogin(
    _LoginData getLoginData,
  ) async {
    try {
      final loginModel = await getLoginData();

      return Right(loginModel);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
