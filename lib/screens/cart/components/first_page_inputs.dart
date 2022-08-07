import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/helper/validate_function.dart';
import '../../../viewModel/checkout_view_model.dart';

class FirstPageCheckoutInformation extends StatelessWidget {
  const FirstPageCheckoutInformation({Key? key, required this.pageController})
      : super(key: key);
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final checkoutViewModel = Provider.of<CheckoutViewModel>(context);
    final _formKey = GlobalKey<FormState>();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 60),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _phoneNumberFormField(checkoutViewModel),
            _addressFormField(checkoutViewModel),
            ElevatedButton(
              onPressed: () =>
                  submitButton(checkoutViewModel, _formKey, pageController),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Checkout"),
              ),
            )
          ],
        ),
      ),
    );
  }

  TextFormField _phoneNumberFormField(CheckoutViewModel checkoutViewModel) {
    return TextFormField(
      textDirection: TextDirection.rtl,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          hintText: "Phone Number", hintTextDirection: TextDirection.rtl),
      validator: Validator.phoneNumber,
      onSaved: checkoutViewModel.savePhoneNumber,
    );
  }

  TextFormField _addressFormField(CheckoutViewModel checkoutViewModel) {
    return TextFormField(
      textDirection: TextDirection.rtl,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: "Address",
        hintTextDirection: TextDirection.rtl,
        alignLabelWithHint: true,
      ),
      validator: Validator.address,
      onSaved: checkoutViewModel.saveAddress,
    );
  }

  void submitButton(CheckoutViewModel checkoutViewModel,
      GlobalKey<FormState> formKey, PageController pageController) async {
    if (!formKey.currentState!.validate()) {
      // not validate form
      return;
    }
    // send to server
    formKey.currentState!.save();
    await checkoutViewModel.postCheckoutToPay();
    pageController.jumpToPage(1);
  }
}
