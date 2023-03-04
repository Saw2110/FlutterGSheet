import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmanager/src/screen/validation/register/bloc/register_bloc.dart';
import 'package:passmanager/src/theme/theme.dart';
import 'package:passmanager/src/utils/utils.dart';
import 'package:passmanager/src/widget/widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with FormValidator {
  final RegisterBloc _registerBloc = RegisterBloc();

  TextEditingController fullNameController = TextEditingController(text: "");
  TextEditingController userNameController = TextEditingController(text: "");
  TextEditingController contactController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  TextEditingController confirmPassController = TextEditingController(text: "");

  GlobalKey<FormState> fullNameKey = GlobalKey<FormState>();
  GlobalKey<FormState> contactKey = GlobalKey<FormState>();
  GlobalKey<FormState> emailKey = GlobalKey<FormState>();
  GlobalKey<FormState> passwordKey = GlobalKey<FormState>();
  GlobalKey<FormState> confirmPassKey = GlobalKey<FormState>();

  Future clear() async {
    Future.delayed(const Duration(seconds: 0), () async {
      fullNameController = TextEditingController(text: "");
      userNameController = TextEditingController(text: "");
      contactController = TextEditingController(text: "");
      emailController = TextEditingController(text: "");
      passwordController = TextEditingController(text: "");
      confirmPassController = TextEditingController(text: "");
    });
  }

  @override
  void initState() {
    super.initState();
    clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      bloc: _registerBloc,
      builder: (BuildContext context, state) {
        if (state is RegisterError) {
          Future.delayed(const Duration(seconds: 0), () {
            ShowToast(context).error(state.message);
          });
        }
        if (state is RegisterLoading) {
          return LoadingScreen.loadingScreen(
            child: buildWidget(),
          );
        }
        if (state is RegisterLoaded) {
          Future.delayed(const Duration(seconds: 0), () async {
            Navigator.pop(context);
            await ShowToast(context).success(state.message);
          });
        }
        return buildWidget();
      },
    );
  }

  Widget buildWidget() {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          SafeArea(
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Text(
                    "Create Account",
                    style: kLoginTitleTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Create a new account",
                    style: kCaptionTextStyle,
                    textAlign: TextAlign.center,
                  ),

                  ///
                  verticalSpace(height: 50.0),
                  Form(
                    key: fullNameKey,
                    child: TextFormField(
                      controller: fullNameController,
                      onChanged: (number) {
                        if (fullNameKey.currentState!.validate()) {}
                        setState(() {});
                      },
                      validator: (number) {
                        if (number!.isNotEmpty) {
                          return null;
                        } else {
                          return 'Enter a valid Number';
                        }
                      },
                      decoration: TextFormDecoration.decoration(
                        hintText: "",
                        labelText: "FULL NAME",
                        prefixIcon: Icons.person_outline,
                      ),
                    ),
                  ),
                  verticalSpace(height: 20.0),
                  Form(
                    key: contactKey,
                    child: TextFormField(
                      controller: contactController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 10,
                      onChanged: (number) {
                        if (contactKey.currentState!.validate()) {}
                      },
                      validator: (number) {
                        if (isMobileNumberValid(number!)) {
                          return null;
                        } else {
                          return 'Enter a valid Number';
                        }
                      },
                      decoration: TextFormDecoration.decoration(
                        hintText: "",
                        labelText: "PHONE",
                        prefixIcon: Icons.phone_outlined,
                      ),
                    ),
                  ),
                  verticalSpace(height: 20.0),
                  Form(
                    key: emailKey,
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (number) {
                        if (emailKey.currentState!.validate()) {}
                      },
                      validator: (email) {
                        if (isEmailValid(email!)) {
                          return null;
                        } else {
                          return 'Enter a valid Number';
                        }
                      },
                      decoration: TextFormDecoration.decoration(
                        hintText: "",
                        labelText: "EMAIL",
                        prefixIcon: Icons.mail_outline,
                      ),
                    ),
                  ),
                  verticalSpace(height: 20.0),
                  Form(
                    key: passwordKey,
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      obscuringCharacter: "X",
                      onChanged: (number) {
                        if (passwordKey.currentState!.validate()) {}
                      },
                      validator: (number) {
                        if (isPasswordValid(number!)) {
                          return null;
                        } else {
                          return 'Enter a valid Number';
                        }
                      },
                      decoration: TextFormDecoration.decoration(
                        hintText: "",
                        labelText: "PASSWORD",
                        prefixIcon: Icons.password,
                      ),
                    ),
                  ),
                  verticalSpace(height: 20.0),
                  Form(
                    key: confirmPassKey,
                    child: TextFormField(
                      controller: confirmPassController,
                      obscureText: true,
                      obscuringCharacter: "X",
                      onChanged: (number) {
                        if (confirmPassKey.currentState!.validate()) {}
                      },
                      validator: (number) {
                        if (!isPasswordValid(number!)) {
                          return 'Enter a valid Number';
                        } else if (confirmPassController.text.toUpperCase() !=
                            passwordController.text.toUpperCase()) {
                          return "Password doesnot match";
                        } else {
                          return null;
                        }
                      },
                      decoration: TextFormDecoration.decoration(
                        hintText: "",
                        labelText: "CONFIRM PASSWORD",
                        prefixIcon: Icons.password,
                      ),
                    ),
                  ),

                  verticalSpace(height: 20.0),

                  ElevatedButton(
                    onPressed: _onUserRegisterButtonPressed,
                    child: const Text("CREATE ACCOUNT"),
                  ),

                  verticalSpace(height: 30.0),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          style: kSubTextStyle.copyWith(color: Colors.black),
                          children: <TextSpan>[
                            const TextSpan(text: "Already have account? "),
                            TextSpan(
                              text: 'Login',
                              style: kSubTextStyle.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]),
                      textScaleFactor: 1.0,
                    ),
                  )
                ],
              ).ph(20),
            ),
          ),
          SafeArea(
            child: BackButton(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }

  _onUserRegisterButtonPressed() {
    if (fullNameKey.currentState!.validate()) {
      if (contactKey.currentState!.validate()) {
        if (emailKey.currentState!.validate()) {
          if (passwordKey.currentState!.validate()) {
            if (confirmPassKey.currentState!.validate()) {
              _registerBloc.add(
                RegisterNewUser(
                  fullName: fullNameController.text.trim(),
                  contact: contactController.text.trim(),
                  username: userNameController.text.trim(),
                  password: passwordController.text.trim(),
                  email: emailController.text.trim(),
                ),
              );
            }
          }
        }
      }
    }
  }
}
