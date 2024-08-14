import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/network/network_info.dart';
import 'features/product/data/data_sources/product_local_data_source.dart';
import 'features/product/data/data_sources/product_remote_data_source.dart';
import 'features/product/data/repositories/product_repository_impl.dart';
import 'features/product/domain/usecases/delete_product.dart';
import 'features/product/domain/usecases/get_all_products.dart';
import 'features/product/domain/usecases/get_product.dart';
import 'features/product/domain/usecases/insert_product.dart';
import 'features/product/domain/usecases/update_product.dart';
import 'features/product/presentation/bloc/product_bloc.dart';

GetIt sl = GetIt.instance;

void init() {
// bloc
  sl.registerFactory(
    () => ProductBloc(
        getAllProducts: sl(),
        getProduct: sl(),
        updateProduct: sl(),
        deleteProduct: sl(),
        insertProduct: sl()),
  );

// data_sources
  sl.registerLazySingleton(
    () => ProductRemoteDataSourceImpl(
      client: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => ProductLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

// repositories
  sl.registerLazySingleton(
    () => ProductRepositoryImpl(
      sl(),
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

// use cases
  sl.registerLazySingleton(
    () => GetAllProducts(
      sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetProduct(
      sl(),
    ),
  );
  sl.registerLazySingleton(
    () => UpdateProduct(
      sl(),
    ),
  );
  sl.registerLazySingleton(
    () => DeleteProduct(
      sl(),
    ),
  );
  sl.registerLazySingleton(
    () => InsertProduct(
      sl(),
    ),
  );

  // core
  sl.registerFactory(
    () => NetworkInfoImpl(
      sl(),
    ),
  );
  sl.registerLazySingleton(
    () => InternetConnectionChecker(),
  );
}
