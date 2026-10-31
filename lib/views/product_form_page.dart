import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/app_theme.dart';
import '../models/product.dart';
import '../models/product_category.dart';
import '../viewmodels/product_form_view_model.dart';
import 'category_presentation.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  late final ProductFormViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ProductFormViewModel();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  void _submit() {
    final product = _viewModel.submit();
    if (product != null) {
      Navigator.of(context).pop<Product>(product);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cadastrar produto',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
        ),
      ),
      body: AnimatedBuilder(
        animation: _viewModel,
        builder: (context, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _FormHero(),
                const SizedBox(height: 26),
                const Text(
                  'Informações do produto',
                  style: TextStyle(
                    color: AppColors.ink,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Preencha os campos abaixo para adicionar o item ao catálogo.',
                  style: TextStyle(color: AppColors.muted, height: 1.35),
                ),
                const SizedBox(height: 22),
                TextField(
                  key: const Key('product-name-field'),
                  autofocus: true,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: _viewModel.updateName,
                  decoration: InputDecoration(
                    labelText: 'Nome do produto',
                    hintText: 'Ex.: Smartphone Vision Pro',
                    prefixIcon: const Icon(Icons.inventory_2_outlined),
                    errorText: _viewModel.nameError,
                  ),
                ),
                const SizedBox(height: 17),
                TextField(
                  key: const Key('product-price-field'),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]')),
                  ],
                  onChanged: _viewModel.updatePrice,
                  decoration: InputDecoration(
                    labelText: 'Preço',
                    hintText: '0,00',
                    prefixText: 'R\$  ',
                    prefixIcon: const Icon(Icons.payments_outlined),
                    errorText: _viewModel.priceError,
                  ),
                ),
                const SizedBox(height: 17),
                DropdownButtonFormField<ProductCategory>(
                  key: const Key('product-category-field'),
                  initialValue: _viewModel.category,
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: 'Categoria',
                    prefixIcon: const Icon(Icons.category_outlined),
                    errorText: _viewModel.categoryError,
                  ),
                  hint: const Text('Selecione uma categoria'),
                  items: ProductCategory.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Row(
                            children: [
                              Icon(
                                category.icon,
                                size: 20,
                                color: category.color,
                              ),
                              const SizedBox(width: 10),
                              Text(category.label),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: _viewModel.updateCategory,
                ),
                const SizedBox(height: 28),
                ElevatedButton.icon(
                  key: const Key('save-product-button'),
                  onPressed: _submit,
                  icon: const Icon(Icons.check_circle_outline_rounded),
                  label: const Text('Cadastrar produto'),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(
                      color: AppColors.muted,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _FormHero extends StatelessWidget {
  const _FormHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.navy, AppColors.blue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: AppColors.orange,
              borderRadius: BorderRadius.circular(17),
            ),
            child: const Icon(
              Icons.add_box_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Novo no catálogo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Cadastre uma novidade para seus clientes.',
                  style: TextStyle(color: Color(0xFFCAE0F0), height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
