import 'package:flutter/foundation.dart';

import '../models/product.dart';
import '../models/product_category.dart';

class CatalogViewModel extends ChangeNotifier {
  CatalogViewModel({List<Product>? initialProducts})
    : _products = List<Product>.of(initialProducts ?? _defaultProducts);

  static const List<Product> _defaultProducts = [
    Product(
      name: 'Smartphone Vision Pro 5G',
      price: 1899.90,
      category: ProductCategory.smartphones,
    ),
    Product(
      name: 'Notebook UltraBook Air 14',
      price: 4299.00,
      category: ProductCategory.notebooks,
    ),
    Product(
      name: 'Smart TV 4K Vision 55”',
      price: 2799.90,
      category: ProductCategory.televisores,
    ),
    Product(
      name: 'Headphone Pulse ANC',
      price: 349.90,
      category: ProductCategory.audio,
    ),
    Product(
      name: 'Air Fryer Digital 5L',
      price: 429.90,
      category: ProductCategory.eletrodomesticos,
    ),
    Product(
      name: 'Console NextBox Series S',
      price: 2499.00,
      category: ProductCategory.gamers,
    ),
  ];

  final List<Product> _products;
  String _query = '';
  ProductCategory? _selectedCategory;
  int _cartItemCount = 0;

  List<Product> get products => List.unmodifiable(_products);
  int get productCount => _products.length;
  int get cartItemCount => _cartItemCount;
  ProductCategory? get selectedCategory => _selectedCategory;

  List<Product> get visibleProducts {
    final normalizedQuery = _query.trim().toLowerCase();
    return _products
        .where((product) {
          final matchesQuery =
              normalizedQuery.isEmpty ||
              product.name.toLowerCase().contains(normalizedQuery) ||
              product.category.label.toLowerCase().contains(normalizedQuery);
          final matchesCategory =
              _selectedCategory == null ||
              product.category == _selectedCategory;
          return matchesQuery && matchesCategory;
        })
        .toList(growable: false);
  }

  void search(String query) {
    if (_query == query) return;
    _query = query;
    notifyListeners();
  }

  void selectCategory(ProductCategory? category) {
    if (_selectedCategory == category) return;
    _selectedCategory = category;
    notifyListeners();
  }

  void addProduct(Product product) {
    _products.insert(0, product);
    _query = '';
    _selectedCategory = null;
    notifyListeners();
  }

  void addToCart(Product product) {
    _cartItemCount++;
    notifyListeners();
  }
}
