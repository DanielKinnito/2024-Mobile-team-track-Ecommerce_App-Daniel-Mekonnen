part of 'product_bloc_bloc.dart';

sealed class ProductBlocState extends Equatable {
  const ProductBlocState();
  
  @override
  List<Object> get props => [];
}

final class ProductBlocInitial extends ProductBlocState {}
