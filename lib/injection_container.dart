import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/product/data/data_sources/product_local_data_source.dart';
import 'features/product/data/data_sources/product_remote_data_source.dart';
import 'features/product/data/repositories/product_repository_impl.dart';
import 'features/product/domain/repositories/product_repository.dart';
import 'features/product/domain/usecases/delete_product.dart';
import 'features/product/domain/usecases/get_all_products.dart';
import 'features/product/domain/usecases/get_product.dart';
import 'features/product/domain/usecases/insert_product.dart';
import 'features/product/domain/usecases/update_product.dart';
import 'features/product/presentation/bloc/product_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Externals
  sl.registerLazySingleton<NetworkInfoImpl>(() => NetworkInfoImpl(sl()));
  var shared = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => shared);
  sl.registerLazySingleton<http.Client>(() => http.Client());
  sl.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // Data Sources
  sl.registerLazySingleton<ProductRemoteDataSourceImpl>(
      () => ProductRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<ProductLocalDataSourceImpl>(
      () => ProductLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(sharedPreferences: sl()));

  //! Features
  // Repositories

  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
        ProductRemoteDataSourceImpl(client: sl()),
        ProductLocalDataSourceImpl(sharedPreferences: sl()),
        NetworkInfoImpl(sl()),
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));

  // Use Cases
  sl.registerLazySingleton<GetAllProducts>(() => GetAllProducts(sl()));
  sl.registerLazySingleton<GetProduct>(() => GetProduct(sl()));
  sl.registerLazySingleton<InsertProduct>(() => InsertProduct(sl()));
  sl.registerLazySingleton<DeleteProduct>(() => DeleteProduct(sl()));
  sl.registerLazySingleton<UpdateProduct>(() => UpdateProduct(sl()));
  // sl.registerLazySingleton(()=> Up)

  //BLoc
  sl.registerFactory(() => ProductBloc(
      getAllProducts: sl(),
      getProduct: sl(),
      updateProduct: sl(),
      deleteProduct: sl(),
      insertProduct: sl()));
}
