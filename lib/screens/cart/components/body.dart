import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:shop_app/product/repo/api_status.dart';
import 'package:shop_app/viewModel/cart_view_model.dart';

import '../../../size_config.dart';
import 'cart_card.dart';

class Body extends StatelessWidget {
  final CartViewModel cartViewModel;
  const Body({super.key, required this.cartViewModel});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: ListView.builder(
        itemCount: cartViewModel.cartListModel.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            key: Key(cartViewModel.cartListModel[index].id.toString()),
            confirmDismiss: (c) {
              return showDialog<bool>(
                  context: context,
                  builder: (ctx) =>
                      AlertDialog(title: Text("Are you sure?"), actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(ctx).pop(false);
                          },
                          child: Text("No"),
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final repo = await cartViewModel.deleteCart(
                                cartViewModel.cartListModel[index].id!);

                            if (repo is Success) {
                              Navigator.of(ctx).pop(true);
                              await showDialog(
                                  context: context,
                                  builder: (c) {
                                    return AlertDialog(
                                      title: Text("Success Deleted"),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(c).pop(false);
                                          },
                                          child: Text("No"),
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.orange),
                                        ),
                                      ],
                                    );
                                  });
                            }
                          },
                          child: Text("Yes"),
                        )
                      ])).then((value) => value);
            },
            direction: DismissDirection.endToStart,
            background: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xFFFFE6E6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Spacer(),
                  SvgPicture.asset("assets/icons/Trash.svg"),
                ],
              ),
            ),
            child: CartCard(cart: cartViewModel.cartListModel[index]),
          ),
        ),
      ),
    );
  }
}
