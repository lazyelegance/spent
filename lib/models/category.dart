class Category {
  final String name, icon;

  Category({this.name, this.icon});

  Category fromString({String name}) => Category(name: name);

  @override
  String toString() {
    return 'Category (name: $name)';
  }
}
