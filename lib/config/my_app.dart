import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../src/services/router/router.dart';
import '../src/theme/theme.dart';
import '../src/widget/widget.dart';
import 'state_list.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: listeners,
      child: CheckConnection(
        isOffline: const NoConnection(),
        isOnline: MaterialApp(
          theme: ThemeData(
            fontFamily: 'Amarante',
            useMaterial3: true,
            primaryColor: primaryColor,
            primarySwatch: primarySwatch,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: primaryColor),
                ),
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
          title: 'Hide Pass',
          initialRoute: splashPath,
          onGenerateRoute: RouteGenerator.generateRoute,
          // home: const SplashScreen(),
        ),
      ),
    );
  }
}
