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
import 'features/user/data/datasources/user_local_data_source.dart';
import 'features/user/data/datasources/user_remote_data_source.dart';
import 'features/user/data/repositories/user_repository_impl.dart';
import 'features/user/domain/repositories/auth_facade_impl.dart';
import 'features/user/domain/repositories/user_repository.dart';
import 'features/user/domain/usecase/login_user.dart';
import 'features/user/domain/usecase/logout_user.dart';
import 'features/user/domain/usecase/register_user.dart';
import 'features/user/presentation/bloc/login_bloc.dart';
import 'features/user/presentation/bloc/logout_bloc.dart';
import 'features/user/presentation/bloc/register_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Externals
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<http.Client>(() => http.Client());
  sl.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());

  // Network Info
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(sl<InternetConnectionChecker>()));

  // Data Sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(
            client: sl<http.Client>(),
            sharedPreferences: sl<SharedPreferences>(),
          ));

  sl.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(sharedPreferences: sl<SharedPreferences>()));

  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: sl<http.Client>()));
  sl.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl(sharedPreferences: sl<SharedPreferences>()));
  

  // Repositories
  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(
            remoteDataSource: sl<ProductRemoteDataSource>(),
            localDataSource: sl<ProductLocalDataSource>(),
            networkInfo: sl<NetworkInfo>(),
          ));

  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(
            remoteDataSource: sl<UserRemoteDataSource>(),
            networkInfo: sl<NetworkInfo>(),
          ));

  // Use Cases
  sl.registerLazySingleton<GetAllProducts>(() => GetAllProducts(sl<ProductRepository>()));
  sl.registerLazySingleton<GetProduct>(() => GetProduct(sl<ProductRepository>()));
  sl.registerLazySingleton<InsertProduct>(() => InsertProduct(sl<ProductRepository>()));
  sl.registerLazySingleton<DeleteProduct>(() => DeleteProduct(sl<ProductRepository>()));
  sl.registerLazySingleton<UpdateProduct>(() => UpdateProduct(sl<ProductRepository>()));
  
  sl.registerLazySingleton<LoginUser>(() => LoginUser(userRepository: sl<UserRepository>()));
  sl.registerLazySingleton<RegisterUser>(() => RegisterUser(sl<UserRepository>()));
  sl.registerLazySingleton<LogOut>(() => LogOut(sl<UserLocalDataSourceImpl>()));

  sl.registerLazySingleton<AuthFacadeImpl>(
      () => AuthFacadeImpl(
            loginUseCase: sl<LoginUser>(),
            registerUseCase: sl<RegisterUser>(),
          ));

  // BLoC
  sl.registerFactory(() => ProductBloc(
        getAllProducts: sl<GetAllProducts>(),
        getProduct: sl<GetProduct>(),
        updateProduct: sl<UpdateProduct>(),
        deleteProduct: sl<DeleteProduct>(),
        insertProduct: sl<InsertProduct>(),
      ));

  sl.registerFactory(() => RegisterBloc(registerUser: sl<RegisterUser>()));

  sl.registerFactory(() => LoginBloc(
        loginUser: sl<LoginUser>(),
        sharedPreferences: sl<SharedPreferences>(),
      ));
  sl.registerLazySingleton(() => LogoutBloc(sl<UserLocalDataSourceImpl>()));
}
