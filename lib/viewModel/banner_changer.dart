import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';

class BannerChanger extends ChangeNotifier {
  final CarouselController _controller = CarouselController();
  CarouselController get controller => _controller;

  int numberOfImages = 0;
  int currentImageIndex = 0;
  void setNumberOfImages(int nm) {
    numberOfImages = nm;
  }

  void nextImage() {
    _controller.nextPage();
    if (currentImageIndex == numberOfImages - 1) {
      currentImageIndex = 0;
    } else {
      currentImageIndex++;
    }
    notifyListeners();
  }

  void previousImage() {
    _controller.previousPage();
    if (currentImageIndex == 0) {
      currentImageIndex = numberOfImages - 1;
    } else {
      currentImageIndex--;
    }
    notifyListeners();
  }

  void changeImageOn(int imageIndex) {
    _controller.animateToPage(imageIndex);
    currentImageIndex = imageIndex;
    notifyListeners();
  }

  void setCurrentImagePage(int currentPage, reson) {
    currentImageIndex = currentPage;
    notifyListeners();
  }
}
