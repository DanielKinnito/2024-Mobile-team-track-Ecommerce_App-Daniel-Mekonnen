import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:myapp/core/network/network_info.dart';
import 'package:myapp/features/user/domain/repositories/user_repository.dart';

import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks([
  UserRepository,
  NetworkInfo,
  SharedPreferences,
  InternetConnectionChecker,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
