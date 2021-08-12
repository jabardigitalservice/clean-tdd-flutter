import 'package:clean_tdd_flutter/features/content/data/models/ContentModel.dart';
import 'package:dartz/dartz.dart';

abstract class ContentRepository {
  Future<Either<Exception, ContentModel>> getContentParam(int? page);
}
