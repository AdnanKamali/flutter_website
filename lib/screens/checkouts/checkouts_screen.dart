import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/viewModel/checkout_view_model.dart';
import 'components/body.dart';

class CheckoutsScreen extends StatelessWidget {
  static String routeName = "/checkout-screen";
  @override
  Widget build(BuildContext context) {
    final checkoutViewModel = Provider.of<CheckoutViewModel>(context);
    return _ui(checkoutViewModel);
  }

  Widget _ui(CheckoutViewModel checkoutViewModel) {
    if (checkoutViewModel.loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (checkoutViewModel.userErro != null) {
      return Center(
        child: Text("Error"),
      );
    }
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 221, 221, 221),
      appBar: AppBar(
        title: Text(
          "Checkouts",
          style: TextStyle(color: Colors.red),
        ),
      ),
      body: Body(
        checkoutViewModel: checkoutViewModel,
      ),
      // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
