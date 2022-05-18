import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/responsive.dart';

import '../../../models/Product.dart';

class MorePopularProduct extends StatelessWidget {
  MorePopularProduct({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Popular Product",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: GridView.builder(
            itemCount: demoProducts.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Responsive.isDesktop(context)
                  ? 4
                  : Responsive.isTablet(context)
                      ? 3
                      : 2,
              childAspectRatio: 2 / 3,
              // crossAxisSpacing: 30,
            ),
            itemBuilder: (ctx, index) =>
                ProductCard(product: demoProducts[index])),
      ),
    );
  }
}
