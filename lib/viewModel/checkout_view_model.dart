import 'package:flutter/material.dart';
import 'package:shop_app/checkout/model/checkout.dart';
import 'package:shop_app/checkout/repo/checkout_services.dart';
import 'package:shop_app/product/repo/api_status.dart';
import 'package:shop_app/utils/user_error.dart';
import 'package:shop_app/viewModel/token_view_model.dart';

class CheckoutViewModel extends ChangeNotifier {
  final TokenViewModel? tokenViewModel;
  CheckoutViewModel({this.tokenViewModel}) {
    if (tokenViewModel != null) {
      if (tokenViewModel?.accessToken != null) {
        _accessToken = tokenViewModel?.accessToken;
      }
    }
    if (_accessToken != null) getCheckouts();
  }

  String? _accessToken;
  void setAccessToken(String accessToken) {
    _accessToken = accessToken;
  }

  bool _loading = false;
  bool get loading => _loading;
  void setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  int? _optCode;
  int? get optCode => _optCode;

  void setOptCode(int optCode) {
    _optCode = optCode;
  }

  UserError? _userError;
  UserError? get userErro => _userError;
  void setUserError(UserError userError) {
    _userError = userError;
    notifyListeners();
  }

  List<CheckoutModel> _checkoutListModel = [];
  List<CheckoutModel> get checkoutListModel => _checkoutListModel;
  void setCheckoutListModel(List<CheckoutModel> checkoutListModel) {
    _checkoutListModel = checkoutListModel;
    notifyListeners();
  }

  CheckoutModel _checkoutModel = CheckoutModel(address: "");
  CheckoutModel get checkoutModel => _checkoutModel;
  void saveAddress(String? address) {
    _checkoutModel.address = address;
  }

  Future<Object> postCheckoutToPay() async {
    final postRepo =
        await CheckoutServices.postCheckout(_checkoutModel, _accessToken!);
    if (postRepo is Success) {
      return postRepo;
    }
    return postRepo;
  }

  void getCheckouts() async {
    setLoading(true);
    final repo = await CheckoutServices.getCheckout(_accessToken!);
    if (repo is Success) {
      setCheckoutListModel(repo.response as List<CheckoutModel>);
    } else {
      setUserError(UserError(message: "Error"));
    }
    setLoading(false);
  }
}
