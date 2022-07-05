import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/viewModel/home_view_model.dart';

import '../../../size_config.dart';
// import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'special_offers.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<ProductViewModel>(context);
    return _ui(homeViewModel, context);
  }

  Widget _ui(ProductViewModel homeViewModel, BuildContext context) {
    if (homeViewModel.loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (homeViewModel.userError != null) {
      return Center(
        child: Text("Error"),
      );

      // showDialog(
      //     context: context,
      //     builder: (ctx) => AlertDialog(
      //           title: Text(homeViewModel.userError?.message as String),
      //           content: Text("Do you want try again?"),
      //           actions: [
      //             ElevatedButton(
      //               onPressed: () {
      //                 // try again
      //               },
      //               child: Text("OK"),
      //             )
      //           ],
      //         ));
    }
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(20)),
          HomeHeader(),
          SizedBox(height: getProportionateScreenWidth(10)),
          DiscountBanner(),
          // Categories(),
          SpecialOffers(),
          SizedBox(height: getProportionateScreenWidth(30)),
          PopularProducts(
            productListModel: homeViewModel.productModelListModel,
          ),
          SizedBox(height: getProportionateScreenWidth(30)),
        ],
      ),
    ));
  }
}
