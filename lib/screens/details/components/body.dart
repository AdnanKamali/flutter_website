import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/product/model/model.dart';
import 'package:shop_app/product/repo/api_status.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/size_config.dart';
import 'package:shop_app/viewModel/cart_view_model.dart';

import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatelessWidget {
  final ProductModel product;
  final CartViewModel cartViewModel;

  const Body({Key? key, required this.product, required this.cartViewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newCartViewModel = Provider.of<CartViewModel>(context);
    newCartViewModel.setProduct(product);
    return ListView(
      children: [
        ProductImages(product: product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                product: product,
                pressOnSeeMore: () {
                  // expand see more detail
                },
              ),
              TopRoundedContainer(
                color: Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    ColorDots(
                      product: product,
                      cartViewModel: newCartViewModel,
                    ),
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.15,
                          right: SizeConfig.screenWidth * 0.15,
                          bottom: getProportionateScreenWidth(40),
                          top: getProportionateScreenWidth(15),
                        ),
                        child: DefaultButton(
                          text: "Add To Cart",
                          press: () async {
                            if (newCartViewModel.cart.color == null) {
                              newCartViewModel
                                  .setColor(product.colors[0].value);
                            }
                            if (newCartViewModel.cart.numOfItem == null) {
                              newCartViewModel.setNumOfProduct(1);
                            }
                            if (newCartViewModel.cart.product == null) {
                              newCartViewModel.setProduct(product);
                            }

                            final sharedPref =
                                await SharedPreferences.getInstance();
                            if (sharedPref.getString("username") == null) {
                              Navigator.of(context)
                                  .pushNamed(SignInScreen.routeName);
                              return;
                            }
                            final repo = await newCartViewModel.postCart();

                            if (repo is Success) {
                              if (repo.code == 101) {
                                cartViewModel.getCarts();
                              } else {
                                cartViewModel
                                    .insertToCartModel(newCartViewModel.cart);
                              }

                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Added To Cart")));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Missed To add"),
                                backgroundColor: Colors.redAccent,
                              ));
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
