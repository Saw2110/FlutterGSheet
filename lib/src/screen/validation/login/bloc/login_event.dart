part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];

  get map => null;
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;

  const LoginButtonPressed({
    required this.username,
    required this.password,
  });
}

// class ContactChange extends LoginEvent {
//   final String contact;

//   const ContactChange({
//     required this.contact,
//   });
// }
