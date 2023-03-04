import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:passmanager/src/constant/constant.dart';

class LoadingScreen {
  static Widget loadingScreen({Widget? child}) {
    return Stack(
      children: [
        child ?? const Scaffold(backgroundColor: Colors.transparent),
        Platform.isAndroid
            ? Stack(
                children: [
                  Container(color: Colors.black.withAlpha(150)),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      width: 90.0,
                      height: 90.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Lottie.asset(AssetsList.loading, height: 100.0),
                    ),
                  ),
                ],
              )
            : Stack(
                children: [
                  Container(color: Colors.black.withAlpha(150)),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Lottie.asset(AssetsList.loading, height: 100.0),
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}
