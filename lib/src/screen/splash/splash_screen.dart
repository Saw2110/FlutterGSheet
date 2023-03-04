import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:passmanager/src/constant/constant.dart';
import 'package:passmanager/src/services/services.dart';
import 'package:passmanager/src/utils/extension/padding_ext.dart';

import '../../theme/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, loginPath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            ///
            AnimatedTextKit(
              repeatForever: true,
              pause: const Duration(microseconds: 100),
              animatedTexts: [
                TypewriterAnimatedText(
                  'Welcome To HIDE PASS ',
                  textStyle: kLoginTitleTextStyle.copyWith(fontSize: 20),
                  textAlign: TextAlign.center,
                  speed: const Duration(milliseconds: 100),
                ),
              ],
              onTap: () {},
            ).ph(5),

            ///
            Lottie.asset(AssetsList.loading, height: 80.0),
          ],
        ),
      ),
    );
  }
}
