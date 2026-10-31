import 'package:flutter/material.dart';

import 'core/app_theme.dart';
import 'viewmodels/catalog_view_model.dart';
import 'views/catalog_page.dart';

class RicardoELetroApp extends StatefulWidget {
  const RicardoELetroApp({super.key});

  @override
  State<RicardoELetroApp> createState() => _RicardoELetroAppState();
}

class _RicardoELetroAppState extends State<RicardoELetroApp> {
  late final CatalogViewModel _catalogViewModel;

  @override
  void initState() {
    super.initState();
    _catalogViewModel = CatalogViewModel();
  }

  @override
  void dispose() {
    _catalogViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RicardoELetro',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: CatalogPage(viewModel: _catalogViewModel),
    );
  }
}
