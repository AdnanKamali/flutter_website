import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/responsive.dart';
import 'package:shop_app/utils/resource_manager/url_manager.dart';
import 'package:shop_app/utils/widgets/images_changer/image_changer.dart';
import 'package:shop_app/viewModel/banner_changer.dart';

class PreviewImagesBanner extends StatefulWidget {
  const PreviewImagesBanner({
    Key? key,
  }) : super(key: key);

  @override
  State<PreviewImagesBanner> createState() => _PreviewImagesBannerState();
}

class _PreviewImagesBannerState extends State<PreviewImagesBanner> {
  Future<void> pageView(int pageIndex) async {
    print(pageIndex);
  }

  // final margin = EdgeInsets.symmetric(horizontal: 20);
  List<String> urls = [
    UrlManager.images.url + "/fonf.jpg",
    UrlManager.images.url + "/forth.jpg",
    UrlManager.images.url + "/second.jpg",
    UrlManager.images.url + "/siven.jpg",
    UrlManager.images.url + "/six.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    final bannerController = Provider.of<BannerChanger>(context, listen: false);
    bannerController.setNumberOfImages(urls.length);
    return Responsive(
      // Mobile Design
      // TODO: Use AspectRatio
      mobile: Container(
        width: MediaQuery.of(context).size.width,
        child: CarouselSlider.builder(
          carouselController: bannerController.controller,
          itemCount: urls.length,
          itemBuilder: (ctx, page, _) {
            return Image.network(
              urls[page],
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            );
          },
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.5,
            // enlargeCenterPage: true,
            autoPlay: true,
            viewportFraction: 1,
            onPageChanged: bannerController.setCurrentImagePage,
          ),
        ),
      ),
      // Desktop Design
      desktop: Stack(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: CarouselSlider.builder(
            carouselController: bannerController.controller,
            itemCount: urls.length,
            itemBuilder: (ctx, page, _) {
              return Image.network(
                urls[page],
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              );
            },
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.7,
              // enlargeCenterPage: true,

              autoPlay: true,

              viewportFraction: 1,
              onPageChanged: bannerController.setCurrentImagePage,
            ),
          ),
        ),
        Positioned(
          child: ImageChanger(),
          right: 60,
          top: MediaQuery.of(context).size.height * 0.5,
        ),
      ]),
    );
  }
}
