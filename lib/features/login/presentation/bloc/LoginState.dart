import 'package:equatable/equatable.dart';
import 'package:clean_tdd_flutter/features/login/data/models/LoginModel.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {}

class LoginLoadingIsOther extends LoginState {}

class LoginLoaded extends LoginState {
  final LoginModel record;

  const LoginLoaded({required this.record});

  @override
  List<Object> get props => [record];

  @override
  String toString() => 'LoginLoaded { record: $record }';
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({required this.error});

  @override
  String toString() {
    return 'State LoginFailure{error: $error}';
  }

  @override
  List<Object> get props => [error];
}
