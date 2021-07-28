import 'package:equatable/equatable.dart';
import 'package:clean_tdd_flutter/features/checkDistribution/data/models/CheckDistributionModel.dart';

abstract class CheckdistributionState extends Equatable {
  const CheckdistributionState();

  @override
  List<Object> get props => [];
}

class CheckdistributionInitial extends CheckdistributionState {
  @override
  List<Object> get props => [];
}

class CheckDistributionLoading extends CheckdistributionState {}

class CheckDistributionLoadingIsOther extends CheckdistributionState {}

class CheckDistributionLoaded extends CheckdistributionState {
  final CheckDistributionModel record;

  const CheckDistributionLoaded({required this.record});

  @override
  List<Object> get props => [record];

  @override
  String toString() => 'CheckDistributionLoaded { record: $record }';
}

class CheckDistributionFailure extends CheckdistributionState {
  final String error;

  CheckDistributionFailure({required this.error});

  @override
  String toString() {
    return 'State CheckDistributionFailure{error: $error}';
  }

  @override
  List<Object> get props => [error];
}
