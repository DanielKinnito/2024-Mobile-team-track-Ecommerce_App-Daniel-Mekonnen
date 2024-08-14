import 'package:equatable/equatable.dart';

abstract class ProductHomeEvent extends Equatable{
  const ProductHomeEvent();

  @override
  List<Object> get props => [];
}

class ProductHomeInitial extends ProductHomeEvent {
  @override
  List<Object> get props => [];
}

class ProductHomeLoadAllProducts extends ProductHomeEvent {
  final 
  @override
  List<Object> get props => [];
}

class ProductHomeLoadSingleProduct extends ProductHomeEvent{
  final int id;

  const ProductHomeLoadSingleProduct(this.id);

  @override
  List<Object> get props => [id];
}