import 'package:clean_tdd_flutter/core/component/BuildTextField.dart';
import 'package:clean_tdd_flutter/core/component/DialogTextOnly.dart';
import 'package:clean_tdd_flutter/core/util/Validations.dart';
import 'package:clean_tdd_flutter/features/content/presentation/pages/ContentScreen.dart';
import 'package:clean_tdd_flutter/features/login/presentation/bloc/Bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_tdd_flutter/features/login/presentation/bloc/Bloc.dart';
import 'package:jds_design/constants/fonts.dart';
import 'package:jds_design/enums/buttons.dart';
import 'package:jds_design/jds_design.dart';

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
        backgroundColor: Colors.white,
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
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 50,
                          child: Image.asset(
                            'assets/logo/home_icon.png',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Login',
                        style: JDSTextTheme.h5
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      BuildTextField(
                          title: 'Username',
                          roundedBorder: 8,
                          controller: _emailController,
                          hintText: "Username",
                          isEdit: true,
                          validation: Validations.usernameValidation,
                          textInputType: TextInputType.text),
                      SizedBox(
                        height: 30,
                      ),
                      BuildTextField(
                          title: 'Password',
                          roundedBorder: 8,
                          controller: _passwordController,
                          obsecureText: true,
                          hintText: "Password",
                          isEdit: true,
                          validation: Validations.passwordValidation,
                          textInputType: TextInputType.text),
                      SizedBox(
                        height: 20,
                      ),
                      // Container(
                      //   width: MediaQuery.of(context).size.width,
                      //   child: JDSButton(
                      //     title: 'Login',
                      //     buttonType: ButtonType.filled,
                      //     background: Colors.blue[700],
                      //     color: Colors.white,
                      //     onPressed: () {
                      //       if (_formKey.currentState!.validate()) {
                      //         FocusScope.of(context).unfocus();
                      //         BlocProvider.of<LoginBloc>(context).add(LoadLogin(
                      //             email: _emailController.text,
                      //             password: _passwordController.text));
                      //       }
                      //     },
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Lupa Password?',
                            style: TextStyle(
                                fontSize: 12,
                                decoration: TextDecoration.underline,
                                color: Color(0xff1E88E5),
                                fontFamily: JDSFonts.LATO,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                elevation:
                                    MaterialStateProperty.resolveWith<double>(
                                  // As you said you dont need elevation. I'm returning 0 in both case
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.disabled)) {
                                      return 0;
                                    }
                                    return 0; // Defer to the widget's default.
                                  },
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all<Color?>(
                                        Colors.blue[700]),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ))),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                FocusScope.of(context).unfocus();
                                BlocProvider.of<LoginBloc>(context).add(
                                    LoadLogin(
                                        email: _emailController.text,
                                        password: _passwordController.text));
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: JDSFonts.LATO,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey[200],
                                height: 1,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'atau',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[500],
                                  fontFamily: JDSFonts.ROBOTO,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey[200],
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                elevation:
                                    MaterialStateProperty.resolveWith<double>(
                                  // As you said you dont need elevation. I'm returning 0 in both case
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.disabled)) {
                                      return 0;
                                    }
                                    return 0; // Defer to the widget's default.
                                  },
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all<Color?>(
                                        Colors.white),
                                foregroundColor:
                                    MaterialStateProperty.all<Color?>(
                                        Colors.blue[700]),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        side: BorderSide(
                                          color: Color(0xff1976D2),
                                        )))),
                            onPressed: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                'Login dengan SIAP Jabar',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: JDSFonts.LATO,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
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
