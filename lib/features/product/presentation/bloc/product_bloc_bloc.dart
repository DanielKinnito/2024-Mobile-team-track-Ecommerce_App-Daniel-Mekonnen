import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_bloc_event.dart';
part 'product_bloc_state.dart';

class ProductBlocBloc extends Bloc<ProductBlocEvent, ProductBlocState> {
  ProductBlocBloc() : super(ProductBlocInitial()) {
    on<ProductBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
