import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/viewModel/banner_changer.dart';

class DotsBanner extends StatelessWidget {
  const DotsBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bannerImageController = Provider.of<BannerChanger>(context);
    return Row(
      children: List.generate(
        bannerImageController.numberOfImages,
        (index) => InkWell(
          onTap: () => bannerImageController.changeImageOn(index),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: CircleAvatar(
              maxRadius: 7,
              backgroundColor: bannerImageController.currentImageIndex == index
                  ? Colors.white
                  : kPrimaryColor.withOpacity(0.7),
              child: CircleAvatar(
                maxRadius: 5,
                backgroundColor:
                    bannerImageController.currentImageIndex == index
                        ? kPrimaryColor.withOpacity(0.7)
                        : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
