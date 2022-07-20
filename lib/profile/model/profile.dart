import 'package:shop_app/user/model/user.dart';

import '../../checkout/model/checkout.dart';

class ProfileModel {
  final UserModel userModel;
  final List<CheckoutModel> listCheckoutModel;
  final String aboutUs;

  ProfileModel(
      {required this.userModel,
      required this.listCheckoutModel,
      required this.aboutUs});
}
