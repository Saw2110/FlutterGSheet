import 'package:flutter/material.dart';
import 'package:passmanager/src/theme/theme.dart';

abstract class CustomDialog {
  String getTitle();

  Widget create(BuildContext context);

  Future<void> show(BuildContext context) {
    var dialog = create(context);
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }
}

class AndroidAlertDialog extends CustomDialog {
  late String title;
  late Widget child;
  AndroidAlertDialog(
    this.title, {
    required this.child,
  });

  @override
  String getTitle() {
    return title;
  }

  @override
  Widget create(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      title: Text(
        getTitle(),
        style: kLoginTitleTextStyle.copyWith(fontSize: 20.0),
        textAlign: TextAlign.center,
      ),
      content: StatefulBuilder(builder:
          (BuildContext context, void Function(void Function()) setState) {
        return child;
      }),
    );
  }
}
