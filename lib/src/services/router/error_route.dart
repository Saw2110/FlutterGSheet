import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomCenter, children: [
      Scaffold(
        appBar: AppBar(
            // backgroundColor: scaffoldBackGroundColor,
            // elevation: 0,
            // leading: IconButton(
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            //   icon: const Icon(Icons.close, color: primaryColor),
            // ),
            ),
        body: const Center(child: Text("Error Route")),
      ),
      // const ButtomClip(),
    ]);
  }
}
