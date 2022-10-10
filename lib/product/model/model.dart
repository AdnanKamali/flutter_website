import 'dart:convert';

import 'package:flutter/material.dart';

// problem in use color when client select it

List<ProductModel> productListModelFromJson(String str) => List.from(json
    .decode(str)["products"]
    .map((element) => ProductModel.fromJson(element)));

class ProductModel {
  final int id;
  final String name, description;
  final List<String> imagesUrl;
  final List<Color> colors;
  final double price;
  final bool isAvalable;

  ProductModel({
    required this.id,
    required this.imagesUrl,
    required this.colors,
    required this.name,
    required this.price,
    required this.description,
    required this.isAvalable,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    List<String> images = [];
    final List<Color> colors = [];
    for (int color in jsonDecode(json["colors"])) {
      colors.add(Color(color));
    }
    for (var image in jsonDecode(json["image_names"])) {
      images.add(image);
    }
    return ProductModel(
      id: json["id"],
      imagesUrl: images,
      colors: colors,
      name: json["name"],
      price: json["price"],
      description: json["description"],
      isAvalable: json["is_avalable"],
    );
  }
}
