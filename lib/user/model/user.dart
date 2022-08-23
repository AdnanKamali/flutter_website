class UserModel {
  String? phoneNumber;
  String? firstName;
  String? lastName;

  UserModel({
    this.phoneNumber,
    this.firstName,
    this.lastName,
  });
  UserModel.base();

  Map<String, dynamic> toJson() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "phone_number": phoneNumber,
    };
  }
}
