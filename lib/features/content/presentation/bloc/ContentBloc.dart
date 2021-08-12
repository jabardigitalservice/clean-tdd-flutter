import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clean_tdd_flutter/features/content/data/models/ContentModel.dart';
import 'package:clean_tdd_flutter/features/content/domain/usecases/GetContent.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:clean_tdd_flutter/core/error/failures.dart';
import 'Bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class ContentBloc extends Bloc<ContentEvent, ContentState> {
  final GetContent? getContent;

  ContentBloc({@required GetContent? content})
      : assert(content != null),
        getContent = content,
        super(ContentInitial());

  ContentState get initialState => ContentInitial();

  @override
  Stream<ContentState> mapEventToState(
    ContentEvent event,
  ) async* {
    if (event is LoadContent) {
      yield ContentLoading();

      final failureOrSuccess = await getContent!(Params(page: event.page));
      yield* _eitherLoadedOrErrorState(failureOrSuccess);
    }

    if (event is InitContent) {
      yield ContentInitial();
    }
  }

  Stream<ContentState> _eitherLoadedOrErrorState(
    Either<Exception, ContentModel> failureOrTrivia,
  ) async* {
    yield failureOrTrivia.fold(
      (failure) => ContentFailure(error: failure.toString()),
      (record) => ContentLoaded(record: record),
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
