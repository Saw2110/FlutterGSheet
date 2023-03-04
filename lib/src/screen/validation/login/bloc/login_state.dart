part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class InitialPhase extends LoginState {}

class LoadingPhase extends LoginState {}

class LoadedPhase extends LoginState {
  final UserResponseModel userModel;
  const LoadedPhase(this.userModel);
}

class ErrorPhase extends LoginState {
  final String message;
  const ErrorPhase({required this.message});
}

// class ContactPhase extends LoginState {
//   final String contactNumber;
//   const ContactPhase({this.contactNumber = ""});
// }
