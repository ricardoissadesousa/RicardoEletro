# RicardoELetro

Catálogo de produtos desenvolvido em Flutter com arquitetura MVVM.

## Funcionalidades

- catálogo construído com `List<Product>` e `ListView.builder`;
- busca e filtro por categoria;
- cards com ícone dinâmico, nome, categoria, preço e ação de compra;
- contador de itens do carrinho e confirmação por `SnackBar`;
- cadastro com validação de nome, preço e `DropdownButtonFormField`;
- inclusão do novo produto sem substituir os itens existentes.

## Arquitetura

```text
lib/
├── models/        # Product e ProductCategory
├── viewmodels/    # estado e regras do catálogo/formulário
├── views/         # telas e apresentação das categorias
├── views/widgets/ # componentes reutilizáveis
└── core/          # tema e formatação de moeda
```

## Executar

```bash
flutter pub get
flutter run
```

## Testar

```bash
flutter test
```
