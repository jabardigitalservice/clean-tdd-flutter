import 'package:clean_tdd_flutter/features/login/data/models/LoginModel.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginModel>> getLoginParam();
}
