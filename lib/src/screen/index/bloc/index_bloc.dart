import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmanager/src/model/model.dart';
import 'package:passmanager/src/services/connection/all_connect.dart';

part 'index_event.dart';
part 'index_state.dart';

class IndexBloc extends Bloc<IndexEvent, IndexState> {
  IndexBloc() : super(IndexInitial()) {
    on<IndexEvent>((event, emit) async {
      try {
        if (event is RegisterNewPassword) {
          emit(IndexLoading());
          await Future.delayed(const Duration(seconds: 3), () async {
            final newPass = {
              PassRegisterModel.platFrom: event.platform,
              PassRegisterModel.contact: event.contact,
              PassRegisterModel.password: event.password,
              PassRegisterModel.createdDate: event.createdDate,
              PassRegisterModel.updatedDate: event.updatedDate,
            };

            await GSheetConnection.insertToPassManager([newPass])
                .whenComplete(() {
              emit(const IndexLoaded(
                message: "Password Saved Successfully",
              ));
            }).onError((error, stackTrace) {
              emit(const IndexError(
                message: "Failed to save password. Please try again.",
              ));
            });

            ///
          });

          ///
        }
      } on NetworkError {
        emit(const IndexError(
          message: "Failed to save password. Is your device online?",
        ));
      }
    });
  }
}
