class ProductEntity{
  String productId;
  String picture;
  String name;
  String description;
  int price;
  int discount;
  int stock;
  int rating;
  int sold;
  String category;

  ProductEntity({
    required this.productId,
    required this.picture,
    required this.name,
    required this.description,
    required this.price,
    required this.discount,
    required this.stock,
    required this.rating,
    required this.sold,
    required this.category,
  });

  Map<String, dynamic> toDocument() {
    return {
      'productId': productId,
      'picture': picture,
      'name': name,
      'description': description,
      'price': price,
      'discount': discount,
      'stock': stock,
      'rating': rating,
      'sold': sold,
      'category': category,
    };
  }

  static ProductEntity fromDocument(Map<String, dynamic> doc) {
    return ProductEntity(
      productId: doc['productId'],
      picture: doc['picture'],
      name: doc['name'],
      description: doc['description'],
      price: doc['price'],
      discount: doc['discount'],
      stock: doc['stock'],
      rating: doc['rating'],
      sold: doc['sold'],
      category: doc['category'],
    );
  }
}