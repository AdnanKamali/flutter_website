import 'package:flutter/material.dart';
import 'package:shop_app/checkout/model/checkout.dart';
import 'package:shop_app/checkout/repo/checkout_services.dart';
import 'package:shop_app/product/repo/api_status.dart';

class CheckoutViewModel extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  void setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  void changeView(PageController pageController) {
    pageController.jumpToPage(1);
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
    await CheckoutServices.postOptCode(code);
  }
}
