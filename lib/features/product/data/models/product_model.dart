import '../../../../core/exception/exception.dart';
import '../../domain/entities/product.dart';

/// Data model class representing a product.
///
/// This class is responsible for converting between [Product] entity and JSON,
/// which is used for serialization and deserialization when interacting with
/// data sources.
class ProductModel extends Product {
  /// The unique identifier of the product.
  final String id;

  /// The name of the product.
  final String name;

  /// A description of the product.
  final String description;

  /// The price of the product.
  final double price;
  @override
  final String imageUrl;

  /// Constructs a new [ProductModel].
  ///
  /// All properties are required.
  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  }) : super(imageUrl: '', id: '', name: '', description: '', price: 0.0);

  /// Converts this [ProductModel] into a [Product] entity.
  Product toEntity() {
    return Product(
      id: id,
      name: name,
      description: description,
      price: price,
      imageUrl: imageUrl,
    );
  }

  /// Creates a new [ProductModel] from a JSON object.
  ///
  /// Throws a [ParsingException] if the JSON is invalid.
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    try {
      return ProductModel(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        price: (json['price'] as num).toDouble(),
        imageUrl: json['imageUrl'] as String,
      );
    } catch (e) {
      throw ParsingException();
    }
  }

  /// Converts this [ProductModel] into a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  /// Converts a list of [ProductModel] into a list of [Product] entities.
  static List<Product> toEntityList(List<ProductModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }

  /// Converts a list of JSON objects into a list of [ProductModel] instances.
  static List<ProductModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ProductModel.fromJson(json)).toList();
  }

  @override
  List<Object> get props => [id, name, description, price, imageUrl];
}
