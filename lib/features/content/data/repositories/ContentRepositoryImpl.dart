import 'package:clean_tdd_flutter/features/content/data/models/ContentModel.dart';
import 'package:clean_tdd_flutter/features/content/domain/repositories/ContentRepository.dart';
import 'package:clean_tdd_flutter/features/content/data/datasources/ContentDataSource.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

typedef Future<ContentModel> _ContentData();

class ContentRepositoryImpl implements ContentRepository {
  final ContentDataSource? contentDataSource;

  ContentRepositoryImpl({
    @required this.contentDataSource,
  });

  @override
  Future<Either<Exception, ContentModel>> getContentParam(int? page) async {
    return await _getContent(() {
      return contentDataSource!.getContent(page);
    });
  }

  Future<Either<Exception, ContentModel>> _getContent(
    _ContentData getContentData,
  ) async {
    try {
      final contentModel = await getContentData();

      return Right(contentModel);
    } on Exception catch (e) {
      print('masuk error left');

      print(e);
      return Left(e);
    }
  }
}
