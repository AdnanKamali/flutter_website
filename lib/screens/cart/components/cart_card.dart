import 'package:flutter/material.dart';
import 'package:shop_app/cart/model/Cart.dart';

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
    return Row(
      children: [
        SizedBox(
          width: 88,
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cart.product!.name,
              style: TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: "\$${cart.product!.price}",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
                children: [
                  TextSpan(
                      text: " x${cart.numOfItem}",
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            )
          ],
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          children: [
            SizedBox(
              height: 35,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Text("Color: "),
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  maxRadius: 8,
                  backgroundColor: Color(cart.color!),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
