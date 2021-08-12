import 'package:equatable/equatable.dart';
import 'package:clean_tdd_flutter/features/content/data/models/ContentModel.dart';

abstract class ContentState extends Equatable {
  const ContentState();

  @override
  List<Object> get props => [];
}

class ContentInitial extends ContentState {
  @override
  List<Object> get props => [];
}

class ContentLoading extends ContentState {}

class ContentLoadingIsOther extends ContentState {}

class ContentLoaded extends ContentState {
  final ContentModel record;

  const ContentLoaded({required this.record});

  @override
  List<Object> get props => [record];

  @override
  String toString() => 'ContentLoaded { record: $record }';
}

class ContentFailure extends ContentState {
  final String error;

  ContentFailure({required this.error});

  @override
  String toString() {
    return 'State ContentFailure{error: $error}';
  }

  @override
  List<Object> get props => [error];
}
