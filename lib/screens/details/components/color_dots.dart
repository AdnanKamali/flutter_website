import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/rounded_icon_btn.dart';

import 'package:shop_app/product/model/model.dart';
import 'package:shop_app/viewModel/cart_view_model.dart';
import 'package:shop_app/viewModel/product_view_model.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ColorDots extends StatelessWidget {
  const ColorDots({
    Key? key,
    required this.product,
    required this.cartViewModel,
  }) : super(key: key);

  final ProductModel product;
  final CartViewModel cartViewModel;

  @override
  Widget build(BuildContext context) {
    // Now this is fixed and only for demo
    return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Consumer<ProductViewModel>(builder: (context, snapshot, child) {
          return Row(
            children: [
              ...List.generate(
                product.colors.length,
                (index) => InkWell(
                  onTap: () {
                    snapshot.setSelectedColor(index);
                    cartViewModel.setColor(product.colors[index].value);
                  },
                  child: ColorDot(
                    color: product.colors[index],
                    isSelected: index == snapshot.selectedColor,
                  ),
                ),
              ),
              Spacer(),
              RoundedIconBtn(
                icon: Icons.remove,
                press: () {
                  snapshot.decremnt();
                  cartViewModel.setNumOfProduct(snapshot.productCount);
                },
              ),
              SizedBox(
                width: getProportionateScreenWidth(20),
                child: Center(
                    child: Text(
                  "${snapshot.productCount}",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.w600),
                )),
              ),
              RoundedIconBtn(
                icon: Icons.add,
                showShadow: true,
                press: () {
                  snapshot.incremnt();
                  cartViewModel.setNumOfProduct(snapshot.productCount);
                },
              ),
            ],
          );
        }));
  }
}

class ColorDot extends StatelessWidget {
  const ColorDot({
    Key? key,
    required this.color,
    this.isSelected = false,
  }) : super(key: key);

  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 2),
      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
      height: getProportionateScreenWidth(40),
      width: getProportionateScreenWidth(40),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border:
            Border.all(color: isSelected ? kPrimaryColor : Colors.transparent),
        shape: BoxShape.circle,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
