import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/product/repo/api_status.dart';
import 'package:shop_app/size_config.dart';
import 'package:shop_app/utils/localzations/demo_localzations.dart';

import '../../../utils/helper/validate_function.dart';
import '../../../viewModel/checkout_view_model.dart';

class FirstPageCheckoutInformation extends StatelessWidget {
  FirstPageCheckoutInformation({Key? key}) : super(key: key);

  // final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final checkoutViewModel = Provider.of<CheckoutViewModel>(context);
    final translate = DemoLocalizations.of(context).translate;
    print(MediaQuery.of(context).viewInsets.bottom);
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenHeight(50),
        horizontal: getProportionateScreenWidth(30),
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextFormField(
            controller: checkoutViewModel.textEditingController,
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              hintText: translate("address"),
              hintTextDirection: TextDirection.rtl,
            ),
            validator: Validator.address,
            onSaved: checkoutViewModel.saveAddress,
          ),
          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom != 0
                ? MediaQuery.of(context).viewInsets.bottom
                : getProportionateScreenHeight(100),
          ),
          SizedBox(
            width: double.infinity,
            child: DefaultButton(
              press: () => submitButton(checkoutViewModel),
              text: translate("checkout"),
            ),
          ),
        ],
      ),
      // ),
    );
  }

  void submitButton(CheckoutViewModel checkoutViewModel) async {
    if (checkoutViewModel.textEditingController.text.isEmpty) {
      // not validate form
      return;
    }
    // send to server
    checkoutViewModel.saveAddress(checkoutViewModel.textEditingController.text);
    final repo = await checkoutViewModel.postCheckoutToPay();
    if (repo is Success) {
      html.window.location.reload();
      // TODO: go to zarin pal
    }
  }
}
