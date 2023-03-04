part of 'index_bloc.dart';

abstract class IndexEvent extends Equatable {
  const IndexEvent();

  @override
  List<Object> get props => [];
}

class RegisterNewPassword extends IndexEvent {
  final String platform;
  final String password;
  final String contact;
  final String createdDate;
  final String updatedDate;

  const RegisterNewPassword({
    required this.platform,
    required this.password,
    required this.contact,
    required this.createdDate,
    required this.updatedDate,
  });
}
