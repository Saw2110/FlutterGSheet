import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CheckConnection extends StatelessWidget {
  final Widget isOnline, isOffline;

  const CheckConnection({
    Key? key,
    required this.isOnline,
    required this.isOffline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Connectivity().onConnectivityChanged,
        builder:
            (BuildContext context, AsyncSnapshot<ConnectivityResult> snapShot) {
          var result = snapShot.data;
          switch (result) {
            case ConnectivityResult.mobile:
              return isOnline;
            case ConnectivityResult.wifi:
              return isOnline;
            case ConnectivityResult.none:
              return isOffline;
            default:
              return isOffline;
          }
        });
  }
}

class NoConnection extends StatelessWidget {
  const NoConnection({Key? key}) : super(key: key);

  onBack() async {
    return SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hide Pass',
      home: WillPopScope(
        onWillPop: () {
          return onBack();
        },
        child: Scaffold(
          backgroundColor: Colors.red.shade50,
          body: const Center(
            child: Text("No Internet Connection"),
          ),
        ),
      ),
    );
  }
}
