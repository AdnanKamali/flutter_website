import 'package:flutter/material.dart';
import 'package:shop_app/responsive.dart';
import 'package:shop_app/screens/home/components/special_offers.dart';

class MoreSpecialOffres extends StatelessWidget {
  MoreSpecialOffres({Key? key, required this.specialOfferCard})
      : super(key: key);
  final List<SpecialOfferCard> specialOfferCard;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Special Offres",
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
    );
  }
}
