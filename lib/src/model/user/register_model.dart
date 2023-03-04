class UserRegisterModel {
  static const String fullName = "FullName";
  static const String email = "Email";
  static const String password = "Password";
  static const String contact = "Contact";

  static List<String> getFields() => [fullName, email, password, contact];
}
