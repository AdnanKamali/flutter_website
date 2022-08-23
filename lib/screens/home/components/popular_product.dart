import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/product/model/model.dart';
import 'package:shop_app/responsive.dart';
import 'package:shop_app/screens/home/components/more_product.dart';
import 'package:shop_app/utils/localzations/demo_localzations.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  PopularProducts({super.key, required this.productListModel});

  final List<ProductModel> productListModel;
  final ScrollController _scrollController = ScrollController();
  double offset = 0;

  @override
  Widget build(BuildContext context) {
    final translate = DemoLocalizations.of(context).translate;
    final isDesktop = Responsive.isDesktop(context);
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
              title: translate("products"),
              press: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MorePopularProduct(
                    productListModel: productListModel,
                  ),
                ));
              }),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        Row(
          children: [
            if (isDesktop && productListModel.length > 5)
              IconButton(
                onPressed: () {
                  if (_scrollController.position.minScrollExtent ==
                      _scrollController.position.pixels) {
                    return;
                  }
                  _scrollController.animateTo(offset -= 500,
                      curve: Curves.linear,
                      duration: Duration(milliseconds: 100));
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.grey,
                ),
              ),
            Expanded(
                child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  ...List.generate(
                    productListModel.length > 10 ? 10 : productListModel.length,
                    (index) {
                      return ProductCard(product: productListModel[index]);
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            )),
            // SizedBox(width: getProportionateScreenWidth(20)),
            if (isDesktop && productListModel.length > 5)
              IconButton(
                  onPressed: () {
                    if (_scrollController.position.maxScrollExtent ==
                        _scrollController.position.pixels) {
                      return;
                    }
                    _scrollController.animateTo(offset += 500,
                        curve: Curves.linear,
                        duration: Duration(milliseconds: 100));
                  },
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.grey,
                  )),
          ],
        ),
      ],
    );
  }
}
