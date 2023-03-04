import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmanager/src/model/model.dart';
import 'package:passmanager/src/services/services.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(InitialPhase()) {
    on<LoginEvent>((event, emit) async {
      try {
        if (event is LoginButtonPressed) {
          emit(LoadingPhase());
          List<UserResponseModel> userData =
              await GSheetConnection.getUserByContactNumber(
            phoneNumber: event.username,
            password: event.password,
          );
          debugPrint("User Data  => ${jsonEncode(userData)}");
          if (userData.isNotEmpty) {
            UserResponseModel myValue = UserResponseModel.fromJson(
              ConvertFromListToMap.getListMap(userData),
            );
            emit(LoadedPhase(myValue));
          } else {
            emit(const ErrorPhase(message: "No User Found."));
          }
        }

        ///
        ///
        // if (event is ContactChange) {
        //   emit(ContactPhase(contactNumber: event.contact));
        // }
      }

      /// On Network Error
      on NetworkError {
        emit(const ErrorPhase(
          message: "Failed to fetch data. is your device online?",
        ));
      }
    });
  }
}
