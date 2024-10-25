import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

const categoryIcons = [
  'food2',
  'travel',
  'entertainment',
  'shopping',
  'investment',
  'salary',
  'subscription',
  'skincare',
  'transportation',
  'health',
  'sport',
  'furniture',
  'others',
  'game',
  'building',
  'food',
  'education',
];

class Category {
  Category({
    this.title,
    required this.icon,
  }) : id = uuid.v4();

  final String id;
  final String? title;
  final Widget icon;
}

// final String id;
  // final String title;
 // final String icon;
 // int totalExpenses;
 // int totalIncome;