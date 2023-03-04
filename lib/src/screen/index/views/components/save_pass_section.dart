import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:passmanager/src/constant/constant.dart';
import 'package:passmanager/src/services/sharepref/sharepref.dart';
import 'package:passmanager/src/theme/theme.dart';
import 'package:passmanager/src/utils/utils.dart';
import 'package:passmanager/src/widget/space_widget.dart';
import 'package:passmanager/src/widget/widget.dart';

import '../../bloc/index_bloc.dart';

class SavePasswordSection extends StatefulWidget {
  const SavePasswordSection({super.key});

  @override
  State<SavePasswordSection> createState() => _SavePasswordSectionState();
}

class _SavePasswordSectionState extends State<SavePasswordSection>
    with FormValidator {
  final IndexBloc _indexBloc = IndexBloc();

  TextEditingController platformController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");

  GlobalKey<FormState> platformKey = GlobalKey<FormState>();
  GlobalKey<FormState> passwordKey = GlobalKey<FormState>();

  Future clear() async {
    Future.delayed(const Duration(seconds: 0), () async {
      platformController = TextEditingController(text: "");
      passwordController = TextEditingController(text: "");
    });
  }

  @override
  void initState() {
    super.initState();
    clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IndexBloc, IndexState>(
      bloc: _indexBloc,
      builder: (BuildContext context, state) {
        if (state is IndexError) {
          Future.delayed(const Duration(seconds: 0), () {
            ShowToast(context).error(state.message);
          });
        }

        ///
        if (state is IndexLoading) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Lottie.asset(AssetsList.loading, height: 100.0),
              ),
            ],
          ).pb(15.0);
        }

        ///
        if (state is IndexLoaded) {
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
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              key: platformKey,
              child: TextFormField(
                controller: platformController,
                keyboardType: TextInputType.emailAddress,
                onChanged: (number) {
                  if (platformKey.currentState!.validate()) {}
                  setState(() {});
                },
                validator: (value) {
                  if (isNotEmpty(value!)) {
                    return null;
                  } else {
                    return '*Required';
                  }
                },
                decoration: TextFormDecoration.decoration(
                  hintText: "",
                  labelText: "Platfrom",
                  prefixIcon: Icons.link,
                ),
              ),
            ),

            ///
            Form(
              key: passwordKey,
              child: TextFormField(
                controller: passwordController,
                keyboardType: TextInputType.emailAddress,
                onChanged: (number) {
                  if (passwordKey.currentState!.validate()) {}
                  setState(() {});
                },
                validator: (password) {
                  if (isNotEmpty(password!)) {
                    return null;
                  } else {
                    return '*Required';
                  }
                },
                decoration: TextFormDecoration.decoration(
                  hintText: "",
                  labelText: "Password",
                  prefixIcon: Icons.password,
                ),
              ),
            ),

            ///
            verticalSpace(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: TextButton(
                    onPressed: () async {
                      await onPasswordSave();
                    },
                    child: const Text("SAVE"),
                  ),
                ),
                Flexible(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("CLOSE"),
                  ),
                ),
              ],
            ),
            verticalSpace(),
          ],
        ).p(15.0, 15.0, 10.0, 0.0);
      },
    );
  }

  onPasswordSave() async {
    if (platformKey.currentState!.validate()) {
      if (passwordKey.currentState!.validate()) {
        debugPrint("Platform => ${platformController.text}");
        debugPrint("Password => ${passwordController.text}");
        _indexBloc.add(
          RegisterNewPassword(
            platform: platformController.text.trim(),
            contact: await GetAllPref.contactNumber(),
            password: passwordController.text.trim(),
            createdDate: MyDate.format("${DateTime.now()}"),
            updatedDate: MyDate.format("${DateTime.now()}"),
          ),
        );
      }
    }
  }
}
