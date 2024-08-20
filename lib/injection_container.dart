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
import 'features/user/data/datasources/user_remote_data_source.dart';
import 'features/user/data/repositories/user_repository_impl.dart';
import 'features/user/domain/repositories/auth_facade_impl.dart';
import 'features/user/domain/repositories/user_repository.dart';
import 'features/user/domain/usecase/login_user.dart';
import 'features/user/domain/usecase/register_user.dart';
import 'features/user/presentation/bloc/login_bloc.dart';
import 'features/user/presentation/bloc/register_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Externals
  var shared = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => shared);
  sl.registerLazySingleton<http.Client>(() => http.Client());
  sl.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // Data Sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(
            client: sl(),
            sharedPreferences: shared,
          ));
  sl.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: sl()));

  // Repositories
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));

  // Use Cases
  sl.registerLazySingleton<GetAllProducts>(() => GetAllProducts(sl()));
  sl.registerLazySingleton<GetProduct>(() => GetProduct(sl()));
  sl.registerLazySingleton<InsertProduct>(() => InsertProduct(sl()));
  sl.registerLazySingleton<DeleteProduct>(() => DeleteProduct(sl()));
  sl.registerLazySingleton<UpdateProduct>(() => UpdateProduct(sl()));
  sl.registerLazySingleton<LoginUser>(() => LoginUser(userRepository: sl()));
  sl.registerLazySingleton<RegisterUser>(() => RegisterUser(sl()));
  sl.registerLazySingleton<AuthFacadeImpl>(
      () => AuthFacadeImpl(loginUseCase: sl(), registerUseCase: sl()));

  // BLoC
  sl.registerFactory(() => ProductBloc(
        getAllProducts: sl(),
        getProduct: sl(),
        updateProduct: sl(),
        deleteProduct: sl(),
        insertProduct: sl(),
      ));
  sl.registerFactory(() => RegisterBloc(registerUser: sl()));
  sl.registerFactory(() => LoginBloc(
        loginUser: sl(),
        sharedPreferences: shared,
      ));
}
