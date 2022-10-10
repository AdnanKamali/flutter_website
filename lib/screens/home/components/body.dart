import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/utils/widgets/images_changer/image_changer.dart';
import 'package:shop_app/viewModel/product_view_model.dart';

import '../../../size_config.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'special_offers.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productViewModel = Provider.of<ProductViewModel>(context);
    return _ui(productViewModel, context);
  }

  Widget _ui(ProductViewModel productViewModel, BuildContext context) {
    if (productViewModel.loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (productViewModel.userError != null) {
      // TODO: Beatiful Error Server
      return Center(
        child: Text(
          "We Have Some Error 400",
          style: TextStyle(fontSize: 80),
        ),
      );
    }
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          // SizedBox(height: getProportionateScreenHeight(20)),
          HomeHeader(),
          SizedBox(height: 14),
          PreviewImagesBanner(),
          // Categories(),
          SizedBox(height: getProportionateScreenWidth(20)),
          Categories(
            productTitleListModel: productViewModel.productListModelWithTitle,
          ),
          SizedBox(height: getProportionateScreenWidth(30)),
          PopularProducts(
            productListModel: productViewModel.productModelListModel,
          ),
          SizedBox(height: getProportionateScreenWidth(30)),
        ],
      ),
    ));
  }
}
