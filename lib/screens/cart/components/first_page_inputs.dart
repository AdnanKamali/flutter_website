import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/product/repo/api_status.dart';
import 'package:shop_app/utils/localzations/demo_localzations.dart';

import '../../../utils/helper/validate_function.dart';
import '../../../viewModel/checkout_view_model.dart';

class FirstPageCheckoutInformation extends StatelessWidget {
  const FirstPageCheckoutInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final checkoutViewModel = Provider.of<CheckoutViewModel>(context);
    final translate = DemoLocalizations.of(context).translate;
    final _formKey = GlobalKey<FormState>();

    return Container(
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 60),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _addressFormField(checkoutViewModel, translate),
            SizedBox(
              width: double.infinity,
              child: DefaultButton(
                press: () => submitButton(checkoutViewModel, _formKey),
                text: translate("checkout"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField _addressFormField(
      CheckoutViewModel checkoutViewModel, String Function(String) translate) {
    return TextFormField(
      textDirection: TextDirection.rtl,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: translate("address"),
        hintTextDirection: TextDirection.rtl,
        alignLabelWithHint: true,
      ),
      validator: Validator.address,
      onSaved: checkoutViewModel.saveAddress,
    );
  }

  void submitButton(
      CheckoutViewModel checkoutViewModel, GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) {
      // not validate form
      return;
    }
    // send to server
    formKey.currentState!.save();
    final repo = await checkoutViewModel.postCheckoutToPay();
    if (repo is Success) {
      // TODO: go to zarin pal
    }
  }
}
