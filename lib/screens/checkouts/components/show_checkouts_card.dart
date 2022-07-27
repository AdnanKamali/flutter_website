import 'package:flutter/material.dart';
import 'package:shop_app/checkout/model/checkout.dart';

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
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.symmetric(
          vertical: fullWidth * 0.02, horizontal: fullWidth * 0.05),
      child: ListTile(
        contentPadding: EdgeInsets.only(
            left: fullWidth * 0.05,
            top: fullWidth * 0.02,
            bottom: fullWidth * 0.02),
        title: Text(
          "Total Price: ${widget.checkoutModel.totalPrice} Rial",
          style: TextStyle(fontSize: 26),
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
                "Address: ${widget.checkoutModel.address}",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "Phone Number: ${widget.checkoutModel.phoneNumber}",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "carts: ",
                style: TextStyle(fontSize: 20),
              ),
              ...List.generate(widget.checkoutModel.cartListModel!.length,
                  (index) {
                final cartListModelProduct =
                    widget.checkoutModel.cartListModel![index];
                return Row(
                  children: [
                    Text(
                      "   ${cartListModelProduct.product?.name} X ${cartListModelProduct.numOfItem} Color: ",
                      style: TextStyle(fontSize: 20),
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
