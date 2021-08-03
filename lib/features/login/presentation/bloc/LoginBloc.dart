import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clean_tdd_flutter/core/usecases/usecase.dart';
import 'package:clean_tdd_flutter/features/login/domain/usecases/GetLogin.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:clean_tdd_flutter/core/error/failures.dart';
import 'package:clean_tdd_flutter/features/login/data/models/LoginModel.dart';
import 'Bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final GetLogin? getLogin;

  LoginBloc({@required GetLogin? login})
      : assert(login != null),
        getLogin = login,
        super(LoginInitial());

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoadLogin) {
      yield LoginLoading();

      final failureOrSuccess =
          await getLogin!(Params(email: event.email, password: event.password));
      yield* _eitherLoadedOrErrorState(failureOrSuccess);
    }
  }

  Stream<LoginState> _eitherLoadedOrErrorState(
    Either<Failure, LoginModel> failureOrTrivia,
  ) async* {
    yield failureOrTrivia.fold(
      (failure) => LoginFailure(error: _mapFailureToMessage(failure)),
      (record) => LoginLoaded(record: record),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
