import '../../../../core/usecase/no_param_usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetAllProducts
    extends NoParamUsecase<Stream<List<Product>>> {
  final ProductRepository repository;

  GetAllProducts(this.repository);

  @override
  Stream<List<Product>> call() {
    return repository.getAllProdcuts();
  }
}