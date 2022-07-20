import 'package:flutter/material.dart';
import 'package:shop_app/product_title/model/product_title.dart';
import 'package:shop_app/screens/home/components/more_product.dart';
import 'package:shop_app/screens/home/components/special_offres_more.dart';
import 'package:shop_app/utils/resource_manager/url_manager.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class SpecialOffers extends StatelessWidget {
  SpecialOffers({
    Key? key,
    required this.productTitleListModel,
  }) : super(key: key);
  List<ProductTitleModel> productTitleListModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: "Special for you",
            press: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MoreSpecialOffres(
                  specialOfferCard: List.generate(
                      productTitleListModel.length,
                      (index) => SpecialOfferCard(
                            category: productTitleListModel[index].name,
                            imageUrl: UrlManager.images.url +
                                "/" +
                                productTitleListModel[index]
                                    .productListModel
                                    .last
                                    .imagesUrl
                                    .last,
                            press: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MorePopularProduct(
                                  productListModel: productTitleListModel[index]
                                      .productListModel,
                                ),
                              ));
                            },
                          )),
                ),
              ));
            },
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                  productTitleListModel.length,
                  (index) => SpecialOfferCard(
                        category: productTitleListModel[index].name,
                        imageUrl: UrlManager.images.url +
                            "/" +
                            productTitleListModel[index]
                                .productListModel
                                .last
                                .imagesUrl
                                .last,
                        press: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MorePopularProduct(
                              productListModel:
                                  productTitleListModel[index].productListModel,
                            ),
                          ));
                        },
                      )),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.imageUrl,
    required this.press,
  }) : super(key: key);

  final String category, imageUrl;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: getProportionateScreenWidth(242),
          height: getProportionateScreenWidth(100),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF343434).withOpacity(0.4),
                        Color(0xFF343434).withOpacity(0.15),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15.0),
                    vertical: getProportionateScreenWidth(10),
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "$category\n",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(18),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
