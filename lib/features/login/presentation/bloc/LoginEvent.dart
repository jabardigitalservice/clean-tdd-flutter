import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoadLogin extends LoginEvent {
  final String? email, password;
  const LoadLogin({this.email, this.password});

  @override
  List<Object> get props => <Object>[];
}

class InitLogin extends LoginEvent {
  @override
  List<Object> get props => <Object>[];
}
