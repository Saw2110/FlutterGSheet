import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmanager/src/screen/validation/register/bloc/register_bloc.dart';

import '../src/screen/validation/login/login.dart';

final listeners = [
  BlocProvider<LoginBloc>(create: (_) => LoginBloc()),
  BlocProvider<RegisterBloc>(create: (_) => RegisterBloc()),
];
