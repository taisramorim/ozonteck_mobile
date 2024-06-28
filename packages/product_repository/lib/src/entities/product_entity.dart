class ProductEntity {
  
  final String productId;
  final String name;
  final String description;
  final int price; 
  final int points;
  final String category;
  final String imageUrl;
  final int personalStock;

  ProductEntity({
    required this.productId,
    required this.name,
    required this.description,
    required this.price,
    required this.points,
    required this.category,
    required this.imageUrl,
    required this.personalStock,
  });

  Map<String, Object?> toDocument() {
    return {
      'productId': productId,
      'name': name,
      'description': description,
      'price': price,
      'points': points,
      'category': category,
      'imageUrl': imageUrl,
      'personalStock': personalStock,
    };
  }

  static ProductEntity fromDocument(Map<String, dynamic> doc) {
    return ProductEntity(
      productId: doc['productId'] as String? ?? '',
      name: doc['name'] as String? ?? 'Unnamed Product',
      description: doc['description'] as String? ?? 'No description',
      price: (doc['price'] as num?)?.toInt() ?? 0,
      points: (doc['points'] as num?)?.toInt() ?? 0,
      category: doc['category'] as String? ?? 'Uncategorized',
      imageUrl: doc['imageUrl'] as String? ?? '',
      personalStock: (doc['personalStock'] as num?)?.toInt() ?? 0,
    );
  }
}