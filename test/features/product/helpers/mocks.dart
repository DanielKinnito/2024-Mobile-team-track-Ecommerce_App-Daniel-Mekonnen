

import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:myapp/features/product/domain/repositories/product_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks([
  ProductRepository,
  ProductRemoteDataSource,
  SharedPreferences,
  InternetConnectionChecker
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])

void main(){}

class ProductRemoteDataSource {
}