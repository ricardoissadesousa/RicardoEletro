import 'product_category.dart';

class Product {
  const Product({
    required this.name,
    required this.price,
    required this.category,
  });

  final String name;
  final double price;
  final ProductCategory category;
}
