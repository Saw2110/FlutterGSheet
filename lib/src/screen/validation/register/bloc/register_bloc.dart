import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmanager/src/model/model.dart';
import 'package:passmanager/src/services/connection/all_connect.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) async {
      try {
        if (event is RegisterNewUser) {
          emit(RegisterLoading());
          await Future.delayed(const Duration(seconds: 3), () async {
            final newUser = {
              UserRegisterModel.fullName: event.fullName,
              UserRegisterModel.contact: event.contact,
              UserRegisterModel.password: event.password,
              UserRegisterModel.email: event.email,
            };

            await GSheetConnection.insertToUserDetails([newUser])
                .whenComplete(() {
              emit(const RegisterLoaded(
                message:
                    "Account Created Successfully. Please Login to proceed.",
              ));
            }).onError((error, stackTrace) {
              emit(const RegisterError(
                message: "Failed to Register. Somethings goes wrong?",
              ));
            });

            ///
          });

          ///
        }
      } on NetworkError {
        emit(const RegisterError(
          message: "Failed to Register. Is your device online?",
        ));
      }
    });
  }
}
