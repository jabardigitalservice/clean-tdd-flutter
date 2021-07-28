import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:clean_tdd_flutter/core/error/failures.dart';
import 'package:clean_tdd_flutter/features/checkDistribution/data/models/CheckDistributionModel.dart';
import 'package:clean_tdd_flutter/features/checkDistribution/domain/usecases/GetCheckDistribution.dart';
import 'package:clean_tdd_flutter/features/checkDistribution/presentation/bloc/Bloc.dart';
import 'Bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class CheckDistributionBloc
    extends Bloc<CheckDistributionEvent, CheckdistributionState> {
  final GetCheckDistribution? getCheckDistribution;

  CheckDistributionBloc({@required GetCheckDistribution? checkDistribution})
      : assert(checkDistribution != null),
        getCheckDistribution = checkDistribution,
        super(CheckdistributionInitial());

  CheckdistributionState get initialState => CheckdistributionInitial();

  @override
  Stream<CheckdistributionState> mapEventToState(
    CheckDistributionEvent event,
  ) async* {
    if (event is LoadCheckDistribution) {
      yield CheckDistributionLoading();

      final failureOrSuccess =
          await getCheckDistribution!(Params(lat: event.lat, long: event.long));
      yield* _eitherLoadedOrErrorState(failureOrSuccess);
    }
  }

  Stream<CheckdistributionState> _eitherLoadedOrErrorState(
    Either<Failure, CheckDistributionModel> failureOrTrivia,
  ) async* {
    yield failureOrTrivia.fold(
      (failure) =>
          CheckDistributionFailure(error: _mapFailureToMessage(failure)),
      (record) => CheckDistributionLoaded(record: record),
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
