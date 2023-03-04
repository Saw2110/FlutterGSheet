part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterNewUser extends RegisterEvent {
  final String username;
  final String fullName;
  final String contact;
  final String password;
  final String email;

  const RegisterNewUser({
    required this.fullName,
    required this.contact,
    required this.username,
    required this.password,
    required this.email,
  });
}
