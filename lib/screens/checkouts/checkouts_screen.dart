import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/size_config.dart';
import 'package:shop_app/utils/localzations/demo_localzations.dart';
import 'package:shop_app/viewModel/checkout_view_model.dart';
import 'components/body.dart';

class CheckoutsScreen extends StatelessWidget {
  static String routeName = "/checkout-screen";
  @override
  Widget build(BuildContext context) {
    final translate = DemoLocalizations.of(context).translate;
    final checkoutViewModel = Provider.of<CheckoutViewModel>(context);
    return _ui(checkoutViewModel, translate);
  }

  Widget _ui(
      CheckoutViewModel checkoutViewModel, String Function(String) translate) {
    if (checkoutViewModel.loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (checkoutViewModel.userErro != null) {
      // TODO: change to persian
      return Scaffold(
        body: Center(
          child: Text("Error"),
        ),
      );
    }
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 221, 221, 221),
      appBar: AppBar(
        title: Text(
          translate("checkouts"),
          style: TextStyle(
              color: Colors.black87,
              fontSize: getProportionateScreenWidth(14),
              fontFamily: "IranSans"),
        ),
      ),
      body: Body(
        checkoutViewModel: checkoutViewModel,
      ),
      // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
