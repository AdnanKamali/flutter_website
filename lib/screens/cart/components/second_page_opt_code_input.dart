import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;

import '../../../product/repo/api_status.dart';
import '../../../viewModel/checkout_view_model.dart';

class SecondPageCheckoutOtp extends StatefulWidget {
  const SecondPageCheckoutOtp({Key? key}) : super(key: key);

  @override
  State<SecondPageCheckoutOtp> createState() => _SecondPageCheckoutOtpState();
}

class _SecondPageCheckoutOtpState extends State<SecondPageCheckoutOtp> {
  bool isEnableSubmitButton = false;
  bool isOptCodeWrong = false;

  @override
  Widget build(BuildContext context) {
    final checkoutViewModel =
        Provider.of<CheckoutViewModel>(context, listen: false);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Center(
          child: SizedBox(
            width: 250,
            child: TextFormField(
              maxLength: 4,
              onChanged: (value) {
                final tryToInt = int.tryParse(value);
                if (tryToInt != null) {
                  if (value.length == 4) {
                    checkoutViewModel.setOptCode(tryToInt);
                    setState(() {
                      isEnableSubmitButton = true;
                    });
                  } else {
                    setState(() {
                      isEnableSubmitButton = false;
                      if (isOptCodeWrong = true) isOptCodeWrong = false;
                    });
                  }
                }
              },
              decoration: InputDecoration(
                counterText: "",
                hintText: "Enter Opt code",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: isOptCodeWrong ? Colors.red : Colors.grey,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: isOptCodeWrong ? Colors.red : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: isEnableSubmitButton
              ? () async {
                  final result = await checkoutViewModel.postOptCode();
                  // checkoutViewModel.setIsEnableSubmitButtonOptCode(false);
                  setState(() {
                    isEnableSubmitButton = false;
                  });
                  if (result is Success) {
                    // get to pay zarin pal with url_luncher
                    html.window.location.reload();
                    // reload or get again
                  } else {
                    setState(() {
                      isOptCodeWrong = true;
                    });
                  }
                }
              : null,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Confirm"),
          ),
        )
      ],
    );
  }
}
