import 'package:equatable/equatable.dart';

abstract class ContentEvent extends Equatable {
  const ContentEvent();
}

class LoadContent extends ContentEvent {
  final int? page;
  const LoadContent({
    this.page,
  });

  @override
  List<Object> get props => <Object>[];
}

class InitContent extends ContentEvent {
  @override
  List<Object> get props => <Object>[];
}
