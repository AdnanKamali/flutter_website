import 'package:flutter/material.dart';
import 'package:shop_app/responsive.dart';
import 'package:shop_app/utils/localzations/demo_localzations.dart';

import '../../sign_up/utils/widgets/category_card.dart';

class MoreCategories extends StatelessWidget {
  MoreCategories({Key? key, required this.specialOfferCard}) : super(key: key);
  final List<CategoryCard> specialOfferCard;
  @override
  Widget build(BuildContext context) {
    final translate = DemoLocalizations.of(context).translate;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.blue.shade50,
        Colors.yellow.shade100,
        Colors.white
      ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            translate("category"),
            style: TextStyle(color: Colors.black54),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: GridView.builder(
              itemCount: specialOfferCard.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Responsive.isDesktop(context)
                    ? 3
                    : Responsive.isTablet(context)
                        ? 2
                        : 1,
                childAspectRatio: 4 / 2,
                // crossAxisSpacing: 30,
              ),
              itemBuilder: (ctx, index) =>
                  Row(children: [specialOfferCard[index]])),
        ),
      ),
    );
  }
}
