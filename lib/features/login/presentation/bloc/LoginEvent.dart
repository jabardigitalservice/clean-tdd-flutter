import 'package:equatable/equatable.dart';
import 'package:clean_tdd_flutter/features/Login/data/models/LoginModel.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoadLogin extends LoginEvent {
  final dynamic lat;
  final dynamic long;
  final dynamic id;

  const LoadLogin({this.lat, this.long, this.id});

  @override
  List<Object> get props => <Object>[lat, long, id];
}

class LoginLoad extends LoginEvent {
  final LoginModel record;

  const LoginLoad(this.record);

  @override
  List<Object> get props => <Object>[record];
}
