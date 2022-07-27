import 'package:flutter/material.dart';
import 'package:shop_app/screens/checkouts/components/show_checkouts_card.dart';
import 'package:shop_app/viewModel/checkout_view_model.dart';

class Body extends StatelessWidget {
  final CheckoutViewModel checkoutViewModel;
  const Body({Key? key, required this.checkoutViewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(
              checkoutViewModel.checkoutListModel.length,
              (index) => ShowCheckoutCart(
                  checkoutModel: checkoutViewModel.checkoutListModel[index]))),
    );
  }
}
