import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../models/product.dart';
import '../models/product_category.dart';
import '../viewmodels/catalog_view_model.dart';
import 'category_presentation.dart';
import 'product_form_page.dart';
import 'widgets/brand_logo.dart';
import 'widgets/cart_button.dart';
import 'widgets/product_card.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key, required this.viewModel});

  final CatalogViewModel viewModel;

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _openProductForm() async {
    final product = await Navigator.of(
      context,
    ).push<Product>(MaterialPageRoute(builder: (_) => const ProductFormPage()));

    if (product == null || !mounted) return;

    _searchController.clear();
    widget.viewModel.addProduct(product);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('${product.name} foi cadastrado com sucesso!'),
          action: SnackBarAction(
            label: 'OK',
            textColor: AppColors.orange,
            onPressed: () {},
          ),
        ),
      );
  }

  void _addToCart(Product product) {
    widget.viewModel.addToCart(product);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle_rounded, color: Color(0xFF5BE49B)),
              const SizedBox(width: 10),
              Expanded(
                child: Text('${product.name} foi adicionado ao carrinho!'),
              ),
            ],
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.viewModel,
      builder: (context, _) {
        final products = widget.viewModel.visibleProducts;

        return Scaffold(
          appBar: AppBar(
            titleSpacing: 20,
            title: const BrandLogo(compact: true),
            actions: [CartButton(itemCount: widget.viewModel.cartItemCount)],
          ),
          body: Column(
            children: [
              _CatalogHeader(
                productCount: widget.viewModel.productCount,
                searchController: _searchController,
                onSearch: widget.viewModel.search,
              ),
              _CategoryFilter(
                selectedCategory: widget.viewModel.selectedCategory,
                onSelected: widget.viewModel.selectCategory,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Produtos em destaque',
                        style: TextStyle(
                          color: AppColors.ink,
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Text(
                      '${products.length} ${products.length == 1 ? 'item' : 'itens'}',
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: products.isEmpty
                    ? const _EmptyCatalog()
                    : ListView.builder(
                        key: const Key('product-list'),
                        padding: const EdgeInsets.fromLTRB(20, 2, 20, 100),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return ProductCard(
                            key: ValueKey(product.name),
                            product: product,
                            onBuy: () => _addToCart(product),
                          );
                        },
                      ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            key: const Key('add-product-button'),
            onPressed: _openProductForm,
            tooltip: 'Cadastrar novo produto',
            icon: const Icon(Icons.add_rounded),
            label: const Text(
              'Novo produto',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        );
      },
    );
  }
}

class _CatalogHeader extends StatelessWidget {
  const _CatalogHeader({
    required this.productCount,
    required this.searchController,
    required this.onSearch,
  });

  final int productCount;
  final TextEditingController searchController;
  final ValueChanged<String> onSearch;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(14, 4, 14, 0),
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.navy, AppColors.blue],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x241261A0),
            blurRadius: 24,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tecnologia que combina\ncom o seu mundo.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        height: 1.08,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      '$productCount produtos esperando por você',
                      style: const TextStyle(
                        color: Color(0xFFBFD8EB),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.11),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.16),
                  ),
                ),
                child: const Icon(
                  Icons.bolt_rounded,
                  color: AppColors.orange,
                  size: 37,
                ),
              ),
            ],
          ),
          const SizedBox(height: 17),
          TextField(
            key: const Key('catalog-search'),
            controller: searchController,
            onChanged: onSearch,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: 'O que você está procurando?',
              hintStyle: const TextStyle(color: AppColors.muted, fontSize: 14),
              prefixIcon: const Icon(
                Icons.search_rounded,
                color: AppColors.blue,
              ),
              filled: true,
              fillColor: Colors.white,
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryFilter extends StatelessWidget {
  const _CategoryFilter({
    required this.selectedCategory,
    required this.onSelected,
  });

  final ProductCategory? selectedCategory;
  final ValueChanged<ProductCategory?> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(20, 13, 20, 5),
        children: [
          _CategoryChip(
            label: 'Todos',
            icon: Icons.grid_view_rounded,
            selected: selectedCategory == null,
            onTap: () => onSelected(null),
          ),
          ...ProductCategory.values.map(
            (category) => _CategoryChip(
              label: category.label,
              icon: category.icon,
              selected: selectedCategory == category,
              onTap: () => onSelected(category),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        selected: selected,
        onSelected: (_) => onTap(),
        showCheckmark: false,
        avatar: Icon(
          icon,
          size: 17,
          color: selected ? Colors.white : AppColors.blue,
        ),
        label: Text(label),
        labelStyle: TextStyle(
          color: selected ? Colors.white : AppColors.ink,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
        selectedColor: AppColors.blue,
        backgroundColor: Colors.white,
        side: BorderSide(color: selected ? AppColors.blue : AppColors.border),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}

class _EmptyCatalog extends StatelessWidget {
  const _EmptyCatalog();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 82,
              height: 82,
              decoration: const BoxDecoration(
                color: Color(0xFFE8F1F8),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.search_off_rounded,
                color: AppColors.blue,
                size: 40,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Nenhum produto encontrado',
              style: TextStyle(
                color: AppColors.ink,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Tente buscar outro nome ou selecionar uma categoria diferente.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.muted, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
