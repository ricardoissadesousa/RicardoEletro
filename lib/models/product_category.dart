enum ProductCategory {
  smartphones('Smartphones'),
  notebooks('Notebooks'),
  televisores('TVs'),
  audio('Áudio'),
  eletrodomesticos('Eletrodomésticos'),
  gamers('Gamer'),
  acessorios('Acessórios');

  const ProductCategory(this.label);

  final String label;
}
