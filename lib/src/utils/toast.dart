import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';

class ShowToast {
  BuildContext context;
  ShowToast(this.context);

  success(message) {
    CherryToast.success(
      title: const Text("Success"),
      displayTitle: false,
      description: Text(message),
      animationType: AnimationType.fromRight,
      animationDuration: const Duration(seconds: 1),
      toastDuration: const Duration(seconds: 2),
      toastPosition: Position.bottom,
      autoDismiss: true,
    ).show(context);
  }

  error(message) {
    CherryToast.error(
      title: const Text("Error"),
      displayTitle: false,
      description: Text(message),
      animationType: AnimationType.fromRight,
      animationDuration: const Duration(seconds: 1),
      toastDuration: const Duration(seconds: 2),
      toastPosition: Position.bottom,
      autoDismiss: true,
    ).show(context);
  }
}
