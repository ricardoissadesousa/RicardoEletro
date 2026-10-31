import 'package:flutter/material.dart';

import '../models/product_category.dart';

extension CategoryPresentation on ProductCategory {
  IconData get icon => switch (this) {
    ProductCategory.smartphones => Icons.smartphone_rounded,
    ProductCategory.notebooks => Icons.laptop_mac_rounded,
    ProductCategory.televisores => Icons.tv_rounded,
    ProductCategory.audio => Icons.headphones_rounded,
    ProductCategory.eletrodomesticos => Icons.kitchen_rounded,
    ProductCategory.gamers => Icons.sports_esports_rounded,
    ProductCategory.acessorios => Icons.cable_rounded,
  };

  Color get color => switch (this) {
    ProductCategory.smartphones => const Color(0xFF1B74E4),
    ProductCategory.notebooks => const Color(0xFF6554C0),
    ProductCategory.televisores => const Color(0xFF00897B),
    ProductCategory.audio => const Color(0xFFE64A6B),
    ProductCategory.eletrodomesticos => const Color(0xFFF57C00),
    ProductCategory.gamers => const Color(0xFF7B1FA2),
    ProductCategory.acessorios => const Color(0xFF546E7A),
  };
}
