import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/product/model/model.dart';
import 'package:shop_app/responsive.dart';

class MorePopularProduct extends StatelessWidget {
  MorePopularProduct({Key? key, required this.productListModel})
      : super(key: key);
  final List<ProductModel> productListModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "محصولات",
          style: TextStyle(color: Colors.red),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: GridView.builder(
            itemCount: productListModel.length,
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
                ProductCard(product: productListModel[index])),
      ),
    );
  }
}
