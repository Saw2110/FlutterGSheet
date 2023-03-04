class PassResponseModel {
  PassResponseModel({
    required this.contact,
    required this.platfrom,
    required this.password,
    required this.createdDate,
    required this.updatedDate,
  });

  final String contact;
  final String platfrom;
  final String password;
  final String createdDate;
  final String updatedDate;

  factory PassResponseModel.fromJson(Map<String, dynamic> json) {
    return PassResponseModel(
      contact: json["Contact"] ?? "",
      platfrom: json["Platfrom"] ?? "",
      password: json["Password"] ?? "",
      createdDate: json["CreatedDate"] ?? "",
      updatedDate: json["UpdatedDate"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "Contact": contact,
        "Platfrom": platfrom,
        "Password": password,
        "CreatedDate": createdDate,
        "UpdatedDate": updatedDate,
      };
}
