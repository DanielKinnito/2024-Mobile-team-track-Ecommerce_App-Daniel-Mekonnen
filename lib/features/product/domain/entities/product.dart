// import 'package:equatable/equatable.dart';

class Product /*extends Equatable*/{
  final String imageUrl;
  final String id;
  final String name;
  final String description;
  final double price;
  final String? category;
  final List? sizes;

  const Product({
    required this.imageUrl,
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.category,
    this.sizes,
  });
  
  // @override
  // // TODO: implement props
  // List<Object?> get props =>[
  //   imageUrl,
  //   id,
  //   name,
  //   description,
  //   price,
  //   category,
  //   sizes,
  // ];
}
