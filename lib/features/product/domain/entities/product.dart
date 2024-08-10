import 'package:equatable/equatable.dart';

/// Represents a product in the e-commerce app.
///
/// Each product has an image URL, ID, name, description, and price.
class Product extends Equatable{
  final String imageUrl;
  final String id;
  final String name;
  final String description;
  final double price;

  const Product({
    required this.imageUrl,
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  });
  
  @override
  // TODO: implement props
  List<Object?> get props => [
    imageUrl,
    id,
    name,
    description,
    price,
  ];
}
