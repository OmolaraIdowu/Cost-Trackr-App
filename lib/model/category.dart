import 'package:flutter/material.dart';

enum Categories {
  travel,
  entertainment,
  food,
  utility,
  subscription,
  tech,
  other
}

class Category {
  // positional arguments
  const Category(
    this.title,
    this.image,
  );

  final String title;
  final Image image;
}
