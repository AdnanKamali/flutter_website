import 'package:flutter/material.dart';
import 'package:shop_app/cart/model/Cart.dart';
import 'package:shop_app/utils/localzations/demo_localzations.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../utils/resource_manager/url_manager.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    final translate = DemoLocalizations.of(context).translate;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: getProportionateScreenWidth(120),
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(
                  UrlManager.images.url + "/" + cart.product!.imagesUrl[0]),
            ),
          ),
        ),
        SizedBox(width: 20),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                cart.product!.name,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(14)),
                maxLines: 2,
              ),
              SizedBox(height: 10),
              Text.rich(
                TextSpan(
                  text: "IRR${cart.product!.price}",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                      fontSize: getProportionateScreenWidth(14)),
                  children: [
                    TextSpan(
                        text: " x${cart.numOfItem}",
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontSize: getProportionateScreenWidth(14))),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(
          width: 45,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text(translate("color") + " :"),
              SizedBox(
                width: 10,
              ),
              CircleAvatar(
                maxRadius: 8,
                backgroundColor: Color(cart.color!),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
