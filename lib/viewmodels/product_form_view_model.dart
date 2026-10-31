import 'package:flutter/foundation.dart';

import '../models/product.dart';
import '../models/product_category.dart';

class ProductFormViewModel extends ChangeNotifier {
  String name = '';
  String priceText = '';
  ProductCategory? category;

  bool _submitted = false;

  String? get nameError {
    if (!_submitted) return null;
    if (name.trim().length < 3) {
      return 'Informe um nome com pelo menos 3 letras';
    }
    return null;
  }

  String? get priceError {
    if (!_submitted) return null;
    final parsedPrice = _parsePrice(priceText);
    if (parsedPrice == null || parsedPrice <= 0) {
      return 'Informe um preço válido e maior que zero';
    }
    return null;
  }

  String? get categoryError {
    if (!_submitted || category != null) return null;
    return 'Selecione uma categoria';
  }

  void updateName(String value) {
    name = value;
    if (_submitted) notifyListeners();
  }

  void updatePrice(String value) {
    priceText = value;
    if (_submitted) notifyListeners();
  }

  void updateCategory(ProductCategory? value) {
    category = value;
    if (_submitted) notifyListeners();
  }

  Product? submit() {
    _submitted = true;
    notifyListeners();

    final parsedPrice = _parsePrice(priceText);
    if (nameError != null || priceError != null || categoryError != null) {
      return null;
    }

    return Product(name: name.trim(), price: parsedPrice!, category: category!);
  }

  double? _parsePrice(String input) {
    var normalized = input.trim().replaceAll(RegExp(r'[^0-9,.]'), '');
    if (normalized.isEmpty) return null;

    if (normalized.contains(',') && normalized.contains('.')) {
      normalized = normalized.replaceAll('.', '').replaceAll(',', '.');
    } else {
      normalized = normalized.replaceAll(',', '.');
    }

    return double.tryParse(normalized);
  }
}
