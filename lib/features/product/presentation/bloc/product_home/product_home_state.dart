import 'package:equatable/equatable.dart';

abstract class ProductHomeState extends Equatable{
  const ProductHomeState();

  @override
  List<Object> get props => [];
}

class ProductHomeInitial extends ProductHomeState {}

class ProductHome