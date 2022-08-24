import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/product/repo/api_status.dart';
import 'package:shop_app/utils/localzations/demo_localzations.dart';
import 'package:shop_app/viewModel/cart_view_model.dart';

import '../../../size_config.dart';
import 'cart_card.dart';

class Body extends StatelessWidget {
  final CartViewModel cartViewModel;
  const Body({super.key, required this.cartViewModel});
  static void showHelpDialog(
    context,
    CartViewModel cartViewModel,
  ) async {
    final translate = DemoLocalizations.of(context).translate;
    await showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: Text(translate("way of remove cart")),
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Text(translate("sweep to right")),
          ),
        ],
      ),
    );
    cartViewModel.setHelpDialog();
  }

  @override
  Widget build(BuildContext context) {
    final translate = DemoLocalizations.of(context).translate;
    if (!cartViewModel.helpDialog) {
      Future.delayed(Duration(seconds: 1))
          .then((value) => showHelpDialog(context, cartViewModel));
    }
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
                builder: (ctx) => AlertDialog(
                  actionsAlignment: MainAxisAlignment.start,
                  title: Text(translate("delete cart")),
                  actions: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                      onPressed: () async {
                        final repo = await cartViewModel
                            .deleteCart(cartViewModel.cartListModel[index].id!);

                        if (repo is Success) {
                          Navigator.of(ctx).pop(true);
                        }
                      },
                      child: Text(translate("confirm")),
                    )
                  ],
                ),
              ).then((value) => value);
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
            child: Container(
              child: CartCard(cart: cartViewModel.cartListModel[index]),
              decoration: BoxDecoration(
                  color: Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(15)),
            ),
          ),
        ),
      ),
    );
  }
}
