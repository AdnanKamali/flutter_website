import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/viewModel/banner_changer.dart';

class NextProvios extends StatelessWidget {
  const NextProvios({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final carouselController = Provider.of<BannerChanger>(context);
    return Row(
      children: [
        InkWell(
          onTap: carouselController.previousImage,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.arrow_back_ios,
              color: Color.fromARGB(255, 88, 88, 88),
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        InkWell(
          onTap: carouselController.nextImage,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.arrow_forward_ios,
              color: Color.fromARGB(255, 88, 88, 88),
            ),
          ),
        ),
      ],
    );
  }
}
