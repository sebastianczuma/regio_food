class Item {
  final String name;
  final String url;
  final String category;

  Item(this.name, this.url, this.category);
}

class ItemList {
  List<Item> products;

  ItemList(this.products);
}
