import 'package:clean_tdd_flutter/core/component/BuildTextField.dart';
import 'package:clean_tdd_flutter/core/component/DialogTextOnly.dart';
import 'package:clean_tdd_flutter/core/util/Validations.dart';
import 'package:clean_tdd_flutter/features/content/presentation/pages/ContentScreen.dart';
import 'package:clean_tdd_flutter/features/login/presentation/bloc/Bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_tdd_flutter/features/login/presentation/bloc/Bloc.dart';

import '../../../../injection_container.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BuildTextField(
                          title: 'Email',
                          roundedBorder: 4,
                          controller: _emailController,
                          hintText: "Masukan Email",
                          isEdit: true,
                          validation: Validations.usernameValidation,
                          textInputType: TextInputType.text),
                      SizedBox(
                        height: 30,
                      ),
                      BuildTextField(
                          title: 'Password',
                          roundedBorder: 4,
                          controller: _passwordController,
                          obsecureText: true,
                          hintText: "Masukan Password",
                          isEdit: true,
                          validation: Validations.passwordValidation,
                          textInputType: TextInputType.text),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              BlocProvider.of<LoginBloc>(context).add(LoadLogin(
                                  email: _emailController.text,
                                  password: _passwordController.text));
                            }
                          },
                          child: Text('Login')),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
