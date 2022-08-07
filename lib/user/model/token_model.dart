// class TokenModel {
//   final String? access_token;
//   final String refresh_token;

//   TokenModel({this.access_token, required this.refresh_token});
//   Map<String, dynamic> toJson() => {
//         "refresh_token": refresh_token,
//       };
//   factory TokenModel.formJson(Map<String, String> json) => TokenModel(
//       refresh_token: json["refresh_token"]!,
//       access_token: json["access_token"]);
// }
