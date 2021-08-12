import 'package:clean_tdd_flutter/core/component/DialogTextOnly.dart';
import 'package:clean_tdd_flutter/features/content/presentation/pages/ContentScreen.dart';
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
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginFailure) {
              showDialog(
                  context: context,
                  builder: (context) => DialogTextOnly(
                        description: state.error,
                        buttonText: 'OK',
                        onOkPressed: () {
                          Navigator.of(context).pop(); // To close the dialog
                          BlocProvider.of<LoginBloc>(context).add(InitLogin());
                        },
                      ));
            } else if (state is LoginLoaded) {
              showDialog(
                  context: context,
                  builder: (context) => DialogTextOnly(
                        description: state.record.toJson().toString(),
                        buttonText: 'OK',
                        onOkPressed: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ContentPage()),
                          );
                        },
                      ));
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is LoginLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<LoginBloc>(context).add(LoadLogin(
                              email: 'jaluowen@email.com',
                              password: 'jalu123'));
                        },
                        child: Text('Login Berhasil')),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<LoginBloc>(context).add(LoadLogin(
                            email: 'jaluowen@emasil.com', password: 'jalu123'));
                      },
                      child: Text('Login Gagal')),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
