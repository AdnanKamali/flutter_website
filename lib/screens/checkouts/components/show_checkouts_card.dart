import 'package:flutter/material.dart';
import 'package:shop_app/checkout/model/checkout.dart';

import '../../../size_config.dart';

class ShowCheckoutCart extends StatefulWidget {
  final CheckoutModel checkoutModel;
  const ShowCheckoutCart({
    Key? key,
    required this.checkoutModel,
  }) : super(key: key);

  @override
  State<ShowCheckoutCart> createState() => _ShowCheckoutCartState();
}

class _ShowCheckoutCartState extends State<ShowCheckoutCart> {
  late double fullWidth;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fullWidth = MediaQuery.of(context).size.width;
  }

  bool _isExpanded = false;
  double? _width = 0;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 250, 250, 247),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.symmetric(
          vertical: fullWidth * 0.02, horizontal: fullWidth * 0.05),
      child: ListTile(
        contentPadding: EdgeInsets.only(
            right: fullWidth * 0.05,
            top: fullWidth * 0.02,
            bottom: fullWidth * 0.02),
        title: Text(
          "قیمت کل : ${widget.checkoutModel.totalPrice} ریال",
          style: TextStyle(fontSize: getProportionateScreenWidth(22)),
        ),
        trailing: IconButton(
            onPressed: () {
              setState(() {
                _isExpanded = !_isExpanded;
                if (_isExpanded) {
                  _width = null;
                } else {
                  _width = 0;
                }
              });
            },
            icon: Icon(Icons.expand_more)),
        subtitle: AnimatedContainer(
          height: _width,
          duration: Duration(seconds: 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "آدرس : ${widget.checkoutModel.address}",
                style: TextStyle(fontSize: getProportionateScreenWidth(18)),
              ),
              // Text(
              //   "Phone Number: ${widget.checkoutModel.phoneNumber}",
              //   style: TextStyle(fontSize: getProportionateScreenWidth(18)),
              // ),
              Text(
                "خرید ها: ",
                style: TextStyle(fontSize: getProportionateScreenWidth(18)),
              ),
              ...List.generate(widget.checkoutModel.cartListModel!.length,
                  (index) {
                final cartListModelProduct =
                    widget.checkoutModel.cartListModel![index];
                return Row(
                  children: [
                    Text.rich(
                      TextSpan(children: [
                        TextSpan(text: "    "),
                        TextSpan(text: "${cartListModelProduct.product?.name}"),
                        TextSpan(text: " "),
                        TextSpan(text: "${cartListModelProduct.numOfItem}"),
                        TextSpan(text: "x"),
                        TextSpan(text: " "),
                        TextSpan(text: "  "),
                        TextSpan(text: "رنگ:"),
                      ]),
                      style:
                          TextStyle(fontSize: getProportionateScreenWidth(18)),
                    ),
                    SizedBox(
                      width: 32,
                    ),
                    CircleAvatar(
                        maxRadius: 8,
                        backgroundColor: Color(cartListModelProduct.color!))
                  ],
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
