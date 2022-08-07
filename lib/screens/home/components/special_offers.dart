import 'package:flutter/material.dart';
import 'package:shop_app/product_title/model/product_title.dart';
import 'package:shop_app/responsive.dart';
import 'package:shop_app/screens/home/components/more_product.dart';
import 'package:shop_app/screens/home/components/special_offres_more.dart';
import 'package:shop_app/utils/localzations/demo_localzations.dart';
import 'package:shop_app/utils/resource_manager/url_manager.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class Categories extends StatelessWidget {
  Categories({
    Key? key,
    required this.productTitleListModel,
  }) : super(key: key);
  List<ProductTitleModel> productTitleListModel;
  final ScrollController _scrollController = ScrollController();
  double offset = 0;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final translate = DemoLocalizations.of(context).translate;
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: translate("category"),
            press: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MoreCategories(
                  specialOfferCard: List.generate(
                      productTitleListModel.length,
                      (index) => CategoryCard(
                            elevated: 8,
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
                                  title: productTitleListModel[index].name,
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
        Row(
          children: [
            if (isDesktop)
              IconButton(
                  onPressed: () {
                    if (_scrollController.position.minScrollExtent ==
                        _scrollController.position.pixels) {
                      return;
                    }
                    _scrollController.animateTo(offset -= 500,
                        curve: Curves.linear,
                        duration: Duration(milliseconds: 100));
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.grey,
                  )),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(
                        productTitleListModel.length,
                        (index) => CategoryCard(
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
                                        productTitleListModel[index]
                                            .productListModel,
                                    title: productTitleListModel[index].name,
                                  ),
                                ));
                              },
                            )),
                    SizedBox(width: getProportionateScreenWidth(20)),
                  ],
                ),
              ),
            ),
            if (isDesktop)
              IconButton(
                  onPressed: () {
                    if (_scrollController.position.maxScrollExtent ==
                        _scrollController.position.pixels) {
                      return;
                    }
                    _scrollController.animateTo(offset += 500,
                        curve: Curves.linear,
                        duration: Duration(milliseconds: 100));
                  },
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.grey,
                  )),
          ],
        ),
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.category,
    required this.imageUrl,
    required this.press,
    this.elevated,
  }) : super(key: key);

  final String category, imageUrl;
  final GestureTapCallback press;
  final double? elevated;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: Card(
        elevation: elevated,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
      ),
    );
  }
}
