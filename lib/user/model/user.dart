class UserModel {
  String? username; // not required this is for test only use for see
  String? phoneNumber;
  String? password;
  String? rePassword;

  UserModel({
    required this.username,
    this.phoneNumber,
    required this.password,
    this.rePassword,
  });
  UserModel.base();

  Map<String, dynamic> toJson() =>
      {"username": username, "password": password, "phone_number": phoneNumber};
}
