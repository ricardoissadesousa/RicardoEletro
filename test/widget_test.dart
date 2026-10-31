import 'package:atv_5/app.dart';
import 'package:atv_5/models/product.dart';
import 'package:atv_5/models/product_category.dart';
import 'package:atv_5/viewmodels/catalog_view_model.dart';
import 'package:atv_5/views/widgets/brand_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RicardoELetro', () {
    testWidgets('exibe o catálogo inicial usando uma lista', (tester) async {
      await tester.pumpWidget(const RicardoELetroApp());

      expect(find.byType(BrandLogo), findsOneWidget);
      expect(find.byKey(const Key('product-list')), findsOneWidget);
      expect(find.text('Smartphone Vision Pro 5G'), findsOneWidget);
      expect(find.text('R\$ 1.899,90'), findsOneWidget);
    });

    testWidgets('adiciona um produto ao carrinho e mostra um SnackBar', (
      tester,
    ) async {
      await tester.pumpWidget(const RicardoELetroApp());

      await tester.tap(
        find.byKey(const ValueKey('buy-Smartphone Vision Pro 5G')),
      );
      await tester.pump();

      expect(
        find.text('Smartphone Vision Pro 5G foi adicionado ao carrinho!'),
        findsOneWidget,
      );
      expect(find.byTooltip('Carrinho com 1 item'), findsOneWidget);
    });

    testWidgets('cadastra um produto e o inclui sem remover os existentes', (
      tester,
    ) async {
      await tester.pumpWidget(const RicardoELetroApp());

      await tester.tap(find.byKey(const Key('add-product-button')));
      await tester.pumpAndSettle();

      expect(find.text('Cadastrar produto'), findsWidgets);

      await tester.enterText(
        find.byKey(const Key('product-name-field')),
        'Teclado Mecânico RGB',
      );
      await tester.enterText(
        find.byKey(const Key('product-price-field')),
        '299,90',
      );
      await tester.tap(find.byKey(const Key('product-category-field')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Acessórios').last);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('save-product-button')));
      await tester.pumpAndSettle();

      expect(find.text('Teclado Mecânico RGB'), findsOneWidget);
      expect(find.text('Smartphone Vision Pro 5G'), findsOneWidget);
      expect(
        find.text('Teclado Mecânico RGB foi cadastrado com sucesso!'),
        findsOneWidget,
      );
    });
  });

  group('CatalogViewModel', () {
    test('filtra e mantém os produtos ao cadastrar um novo', () {
      const original = Product(
        name: 'Notebook Inicial',
        price: 3200,
        category: ProductCategory.notebooks,
      );
      const added = Product(
        name: 'Cabo USB-C',
        price: 59.90,
        category: ProductCategory.acessorios,
      );
      final viewModel = CatalogViewModel(initialProducts: [original]);

      viewModel.addProduct(added);

      expect(viewModel.products, containsAll([original, added]));
      expect(viewModel.productCount, 2);

      viewModel.search('cabo');
      expect(viewModel.visibleProducts, [added]);

      viewModel.dispose();
    });
  });
}
