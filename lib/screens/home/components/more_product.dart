import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/product/model/model.dart';
import 'package:shop_app/responsive.dart';
import 'package:shop_app/utils/localzations/demo_localzations.dart';

class MorePopularProduct extends StatelessWidget {
  MorePopularProduct({Key? key, required this.productListModel, this.title})
      : super(key: key);
  final List<ProductModel> productListModel;
  final String? title;
  @override
  Widget build(BuildContext context) {
    final translate = DemoLocalizations.of(context).translate;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.blue.shade50,
        Colors.yellow.shade100,
        Colors.white
      ], begin: Alignment.bottomLeft, end: Alignment.topRight)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            title ?? translate("products"),
            style: TextStyle(color: Colors.black54, fontFamily: "IranSans"),
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
      ),
    );
  }
}
