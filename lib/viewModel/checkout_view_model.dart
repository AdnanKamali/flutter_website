import 'package:flutter/material.dart';
import 'package:shop_app/checkout/model/checkout.dart';
import 'package:shop_app/checkout/repo/checkout_services.dart';
import 'package:shop_app/product/repo/api_status.dart';
import 'package:shop_app/utils/user_error.dart';

class CheckoutViewModel extends ChangeNotifier {
  CheckoutViewModel() {
    getCheckouts();
  }
  bool _loading = false;
  bool get loading => _loading;
  void setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  UserError? _userError;
  UserError? get userErro => _userError;
  void setUserError(UserError userError) {
    _userError = userError;
    notifyListeners();
  }

  void changeView(PageController pageController) {
    pageController.jumpToPage(1);
  }

  List<CheckoutModel> _checkoutListModel = [];
  List<CheckoutModel> get checkoutListModel => _checkoutListModel;
  void setCheckoutListModel(List<CheckoutModel> checkoutListModel) {
    _checkoutListModel = checkoutListModel;
    notifyListeners();
  }

  CheckoutModel _checkoutModel = CheckoutModel(address: "", phoneNumber: 0);
  CheckoutModel get checkoutModel => _checkoutModel;
  void saveAddress(String? address) {
    _checkoutModel.address = address;
  }

  void savePhoneNumber(String? phoneNumber) {
    final convertPhoneNumber = int.tryParse(phoneNumber!);
    _checkoutModel.phoneNumber = convertPhoneNumber;
  }

  bool _isEnableSubmitButtonOptCode = false;
  bool get isEnableSubmitButtonOptCode => _isEnableSubmitButtonOptCode;
  void setIsEnableSubmitButtonOptCode(bool isEnable) {
    _isEnableSubmitButtonOptCode = isEnable;
    notifyListeners();
  }

  Future<Object> postCheckoutToPay() async {
    final postRepo = await CheckoutServices.postCheckout(_checkoutModel);
    if (postRepo is Success) {
      return postRepo;
    }
    return postRepo;
  }

  Future<void> postOptCode(int code) async {
    final result = await CheckoutServices.postOptCode(code);
    print("Result");
    print(result);
  }

  void getCheckouts() async {
    setLoading(true);
    final repo = await CheckoutServices.getCheckout();
    if (repo is Success) {
      setCheckoutListModel(repo.response as List<CheckoutModel>);
    } else {
      setUserError(UserError(message: "Error"));
    }
    setLoading(false);
  }
}
