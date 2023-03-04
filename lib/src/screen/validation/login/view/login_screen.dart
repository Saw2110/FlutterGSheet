import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:passmanager/src/constant/constant.dart';
import 'package:passmanager/src/screen/validation/login/login.dart';
import 'package:passmanager/src/services/services.dart';
import 'package:passmanager/src/theme/theme.dart';
import 'package:passmanager/src/utils/utils.dart';
import 'package:passmanager/src/widget/widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with FormValidator {
  final LoginBloc _loginBloc = LoginBloc();

  TextEditingController contactController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");

  GlobalKey<FormState> contactKey = GlobalKey<FormState>();
  GlobalKey<FormState> passwordKey = GlobalKey<FormState>();

  FocusNode passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    contactController = TextEditingController(text: "");
    passwordController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginBloc, LoginState>(
          bloc: _loginBloc,
          builder: (context, state) {
            if (state is ErrorPhase) {
              Future.delayed(const Duration(seconds: 0), () {
                ShowToast(context).error(state.message);
              });
            }
            if (state is LoadingPhase) {
              return LoadingScreen.loadingScreen(
                child: screenWidget(),
              );
            }
            if (state is LoadedPhase) {
              Future.delayed(const Duration(seconds: 0), () async {
                Navigator.pushReplacementNamed(context, indexPath);
                await SetAllPref.contactNumber(
                  value: contactController.text.trim(),
                );
              });
            }
            return screenWidget();
          }),
    );
  }

  Widget screenWidget() {
    // final bloc = context.read<LoginBloc>();

    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                AssetsList.loginIcon,
                height: 160.0,
                repeat: true,
                animate: true,
              ),
              Text(
                "Welcome Back",
                style: kLoginTitleTextStyle,
                textAlign: TextAlign.center,
              ),
              Text(
                "Sign to continue",
                style: kCaptionTextStyle,
                textAlign: TextAlign.center,
              ),
              verticalSpace(height: 50.0),
              // Form(
              //   key: contactKey,
              //   child: TextFormField(
              //     controller: contactController,
              //     keyboardType: TextInputType.number,
              //     inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              //     maxLength: 10,
              //     onChanged: (number) {
              //       bloc.add(ContactChange(contact: number));
              //     },
              //     validator: (number) {
              //       if (isMobileNumberValid(number!)) {
              //         return null;
              //       } else {
              //         return 'Enter a valid Number';
              //       }
              //     },
              //     decoration: TextFormDecoration.decoration(
              //       hintText: "",
              //       labelText: "CONTACT",
              //       prefixIcon: Icons.phone,
              //     ),
              //   ),
              // ),

              Form(
                key: contactKey,
                child: TextFormField(
                  controller: contactController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: 10,
                  onChanged: (number) {
                    if (contactKey.currentState!.validate()) {
                      if (number.length == 10) {
                        passwordFocus.requestFocus();
                      }
                    }
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
                    labelText: "CONTACT",
                    prefixIcon: Icons.phone,
                  ),
                ),
              ),

              verticalSpace(height: 20.0),
              Form(
                key: passwordKey,
                child: TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: 10,
                  focusNode: passwordFocus,
                  onChanged: (password) {
                    passwordKey.currentState!.validate();
                  },
                  validator: (password) {
                    if (isPasswordValid(password!)) {
                      return null;
                    } else {
                      return 'Enter a valid password';
                    }
                  },
                  decoration: TextFormDecoration.decoration(
                    hintText: "",
                    labelText: "PASSWORD",
                    prefixIcon: Icons.password,
                  ),
                ),
              ),
              // verticalSpace(),
              // Text(
              //   "Forget Password?",
              //   style: kSubTextStyle,
              //   textAlign: TextAlign.end,
              // ),
              // verticalSpace(height: 50.0),
              verticalSpace(height: 30.0),
              ElevatedButton(
                onPressed: _onLoginButtonPressed,
                child: const Text("LOGIN"),
              ),
              verticalSpace(height: 20.0),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, registerPath);
                },
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: kSubTextStyle.copyWith(color: Colors.black),
                      children: <TextSpan>[
                        const TextSpan(text: "Don't have account? "),
                        TextSpan(
                          text: 'create a new account ',
                          style: kSubTextStyle.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                  textScaleFactor: 1.0,
                ).pa(10),
              )
            ],
          ).ph(20),
        ),
      ),
    );
  }

  _onLoginButtonPressed() {
    if (contactKey.currentState!.validate()) {
      if (passwordKey.currentState!.validate()) {
        _loginBloc.add(
          LoginButtonPressed(
            username: contactController.text.trim(),
            password: passwordController.text.trim(),
          ),
        );
      }
    }
  }
}
