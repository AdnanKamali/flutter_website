import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/product/model/model.dart';
import 'package:shop_app/viewModel/cart_view_model.dart';
import 'package:shop_app/viewModel/product_view_model.dart';

import 'components/body.dart';
import 'components/custom_app_bar.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";
  final ProductDetailsArguments productDetailsArguments;
  DetailsScreen(this.productDetailsArguments);
  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context);
    return Scaffold(
        backgroundColor: Color(0xFFF5F6F9),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height),
          child: CustomAppBar(rating: 0),
        ),
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: CartViewModel(),
            ),
            ChangeNotifierProvider.value(
              value: ProductViewModel(),
            )
          ],
          child: Body(
            product: productDetailsArguments.product,
            cartViewModel: cartViewModel,
          ),
        ));
  }
}

class ProductDetailsArguments {
  final ProductModel product;

  ProductDetailsArguments({required this.product});
}
