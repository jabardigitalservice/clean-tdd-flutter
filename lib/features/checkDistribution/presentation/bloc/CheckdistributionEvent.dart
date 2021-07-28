import 'package:equatable/equatable.dart';
import 'package:clean_tdd_flutter/features/checkDistribution/data/models/CheckDistributionModel.dart';

abstract class CheckDistributionEvent extends Equatable {
  const CheckDistributionEvent();
}

class LoadCheckDistribution extends CheckDistributionEvent {
  final dynamic lat;
  final dynamic long;
  final dynamic id;

  const LoadCheckDistribution({this.lat, this.long, this.id});

  @override
  List<Object> get props => <Object>[lat, long, id];
}

class CheckDistributionLoad extends CheckDistributionEvent {
  final CheckDistributionModel record;

  const CheckDistributionLoad(this.record);

  @override
  List<Object> get props => <Object>[record];
}
