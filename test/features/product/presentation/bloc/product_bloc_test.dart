import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/features/product/domain/usecases/delete_product.dart';
import 'package:myapp/features/product/domain/usecases/get_all_products.dart';
import 'package:myapp/features/product/domain/usecases/get_product.dart';
import 'package:myapp/features/product/domain/usecases/insert_product.dart';
import 'package:myapp/features/product/domain/usecases/update_product.dart';
import 'package:myapp/features/product/presentation/bloc/product_bloc.dart';

class MockGetAllProducts extends Mock implements GetAllProducts {}
class MockGetProduct extends Mock implements GetProduct{}
class MockUpdateProduct extends Mock implements UpdateProduct{}
class MockDeleteProduct extends Mock implements DeleteProduct{}
class MockInsertProduct extends Mock implements InsertProduct{}

void main(){
  late ProductBloc bloc;
  late MockGetAllProducts mockGetAllProducts;
  late MockGetProduct mockGetProduct;
  late MockUpdateProduct mockUpdateProduct;
  late MockDeleteProduct mockDeleteProduct;
  late MockInsertProduct mockInsertProduct;

  setUp((){
    mockGetAllProducts = MockGetAllProducts();
    mockGetProduct = MockGetProduct();
    mockUpdateProduct = MockUpdateProduct();
    mockDeleteProduct = MockDeleteProduct();
    mockInsertProduct = MockInsertProduct();

    bloc = ProductBloc(
      getAllProducts: mockGetAllProducts,
      getProduct: mockGetProduct,
      updateProduct: mockUpdateProduct,
      deleteProduct: mockDeleteProduct,
      insertProduct: mockInsertProduct,
    );
  });

  test('Initial state should be empty.', () async {
    expect(bloc.state, ProductInitial());
  });
}
