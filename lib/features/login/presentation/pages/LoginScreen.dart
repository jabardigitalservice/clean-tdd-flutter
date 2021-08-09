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
            } else if (state is LoginLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is LoginFailure) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Output'),
                      SizedBox(
                        height: 10,
                      ),
                      Text(state.error),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<LoginBloc>(context)
                                .add(InitLogin());
                          },
                          child: Text('Kembali')),
                    ],
                  ),
                ),
              );
            } else if (state is LoginLoaded) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Output'),
                      SizedBox(
                        height: 10,
                      ),
                      Text(state.record.toJson().toString()),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<LoginBloc>(context)
                                .add(InitLogin());
                          },
                          child: Text('Kembali')),
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
