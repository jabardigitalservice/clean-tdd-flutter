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
  Future<Either<Exception, LoginModel>> getLoginParam(
      String? email, password) async {
    return await _getLogin(() {
      return loginDataSource!.getLogin(email, password);
    });
  }

  Future<Either<Exception, LoginModel>> _getLogin(
    _LoginData getLoginData,
  ) async {
    try {
      final loginModel = await getLoginData();

      return Right(loginModel);
    } on Exception catch (e) {
      print('masuk error left');

      print(e);
      return Left(e);
    }
  }
}
