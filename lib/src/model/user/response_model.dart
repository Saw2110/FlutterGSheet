class UserResponseModel {
  UserResponseModel({
    required this.fullName,
    required this.userName,
    required this.password,
    required this.contact,
  });

  final String fullName;
  final String userName;
  final String password;
  final String contact;

  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
      fullName: json["FullName"] ?? "",
      userName: json["UserName"] ?? "",
      password: json["Password"] ?? "",
      contact: json["Contact"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "FullName": fullName,
        "UserName": userName,
        "Password": password,
        "Contact": contact,
      };
}
