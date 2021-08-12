import 'package:clean_tdd_flutter/features/content/data/models/ContentModel.dart';
import 'package:clean_tdd_flutter/features/content/domain/repositories/ContentRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/usecases/usecase.dart';

class GetContent implements UseCase<ContentModel, Params> {
  final ContentRepository repository;

  GetContent(this.repository);

  @override
  Future<Either<Exception, ContentModel>> call(Params params) async {
    return await repository.getContentParam(params.page);
  }
}

class Params extends Equatable {
  final int? page;

  Params({@required this.page});

  @override
  List<Object?> get props => [page];
}
