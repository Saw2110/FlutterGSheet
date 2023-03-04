import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmanager/src/widget/widget.dart';

import 'config/my_app.dart';
import 'src/services/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();

  await GSheetConnection.init().onError((error, stackTrace) {
    runApp(const NoConnection());
  });

  runApp(const MyApp());
}
