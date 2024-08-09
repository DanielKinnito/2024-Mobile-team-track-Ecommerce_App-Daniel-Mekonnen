// Suggested code may be subject to a license. Learn more: ~LicenseLog:1860087483.
import '../../domain/entities/product.dart';

class ProductModel extends Product {
  /// Constructor for the ProductModel
  const ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.imageUrl,
  });

  /// Factory constructor to create a ProductModel from a JSON map
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num?)?.toDouble()??0.0,
      imageUrl: json['imageUrl'],
    );
  }

  factory ProductModel.forLocalJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        imageUrl: json['imageUrl'],
        price: json['price'],
      );
  /// Method to convert the ProductModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  Product toEntity() => Product(
    id: id,
    name: name,
    description: description,
    price: price,
    imageUrl: imageUrl,
  );
}
