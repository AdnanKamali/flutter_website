import 'package:flutter/material.dart';
import 'package:shop_app/product_title/model/product_title.dart';
import 'package:shop_app/responsive.dart';
import 'package:shop_app/screens/home/components/more_product.dart';
import 'package:shop_app/screens/home/components/special_offres_more.dart';
import 'package:shop_app/utils/localzations/demo_localzations.dart';
import 'package:shop_app/utils/resource_manager/url_manager.dart';

import '../../../size_config.dart';
import '../../../utils/resource_manager/category_card.dart';
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
            press: () => onCategoryTap(productTitleListModel, context),
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        Row(
          children: [
            if (isDesktop && productTitleListModel.length > 3)
              rowScrollerButtonToRight(_scrollController),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...generateCategoryRow(productTitleListModel, context),
                    SizedBox(width: getProportionateScreenWidth(20)),
                  ],
                ),
              ),
            ),
            if (isDesktop && productTitleListModel.length > 3)
              rowScrollerButtonToLeft(_scrollController)
          ],
        ),
      ],
    );
  }

  IconButton rowScrollerButtonToLeft(ScrollController _scrollController) {
    return IconButton(
      onPressed: () {
        if (_scrollController.position.maxScrollExtent ==
            _scrollController.position.pixels) {
          return;
        }
        _scrollController.animateTo(offset += 500,
            curve: Curves.linear, duration: Duration(milliseconds: 100));
      },
      icon: Icon(
        Icons.arrow_forward,
        color: Colors.grey,
      ),
    );
  }

  IconButton rowScrollerButtonToRight(ScrollController _scrollController) {
    return IconButton(
      onPressed: () {
        if (_scrollController.position.minScrollExtent ==
            _scrollController.position.pixels) {
          return;
        }
        _scrollController.animateTo(
          offset -= 500,
          curve: Curves.linear,
          duration: Duration(milliseconds: 100),
        );
      },
      icon: Icon(
        Icons.arrow_back,
        color: Colors.grey,
      ),
    );
  }

  void onCategoryTap(
      List<ProductTitleModel> productTitleListModel, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MoreCategories(
          specialOfferCard: List.generate(
            productTitleListModel.length,
            (index) {
              final imagesUrl =
                  productTitleListModel[index].productListModel.last.imagesUrl;
              return CategoryCard(
                elevated: 8,
                category: productTitleListModel[index].name,
                imageUrl: UrlManager.images.url + "/" + imagesUrl.last,
                press: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MorePopularProduct(
                      productListModel:
                          productTitleListModel[index].productListModel,
                      title: productTitleListModel[index].name,
                    ),
                  ));
                },
              );
            },
          ),
        ),
      ),
    );
  }

  List<CategoryCard> generateCategoryRow(
    List<ProductTitleModel> productTitleListModel,
    BuildContext context,
  ) {
    return List.generate(productTitleListModel.length, (index) {
      final imagesUrl =
          productTitleListModel[index].productListModel.last.imagesUrl;
      return CategoryCard(
        category: productTitleListModel[index].name,
        imageUrl: UrlManager.images.url + "/" + imagesUrl.last,
        press: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MorePopularProduct(
              productListModel: productTitleListModel[index].productListModel,
              title: productTitleListModel[index].name,
            ),
          ));
        },
      );
    });
  }
}
