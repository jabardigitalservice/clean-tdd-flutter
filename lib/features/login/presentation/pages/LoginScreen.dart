import 'package:clean_tdd_flutter/features/login/presentation/bloc/Bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_tdd_flutter/features/login/presentation/bloc/Bloc.dart';

import '../../../../injection_container.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (_) => sl<LoginBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is LoginInitial) {
              return Center(
                child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<LoginBloc>(context).add(LoadLogin(
                          email: 'jaluowen@email.com', password: 'jalu123'));
                    },
                    child: Text('Login')),
              );
            } else if (state is LoginLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is LoginFailure) {
              return Center(child: Text(state.error));
            } else if (state is LoginLoaded) {
              return Center(child: Text(state.record.toJson().toString()));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
