import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../../core/constants/constants.dart';
import '../../../../core/exception/exception.dart';

abstract class UserRemoteDataSource {
  Future<String> loginUser(String email, String password);
  Future<String> registerUser(String email, String password, String name);
  Future<String> fetchUserName();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<String> loginUser(String email, String password) async {
    final response = await client.post(
      Uri.parse(UserUrls.loginUser()),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> data = json.decode(response.body);
      final accessToken =
          data['data']['access_token']; // Extract token from the 'data' field
      return accessToken;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> registerUser(
      String email, String password, String name) async {
    final response = await client.post(
      Uri.parse(UserUrls.registerUser()),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
        'name': name,
      }),
    );

    // Log the response for debugging

    if (response.statusCode == 201) {
      final Map<String, dynamic> data = json.decode(response.body);

      // Make sure the data field exists and contains the expected fields
      if (data.containsKey('data') && data['data']['id'] != null) {
        return data['data']['id'];
      } else {
        // Log specific error details for better debugging
        throw ServerException(); // Invalid response structure
      }
    } else {
      // Log server error response
      throw ServerException();
    }
  }

  final String apiUrl =
      'https://g5-flutter-learning-path-be.onrender.com/api/v2/users/me';

  @override
  Future<String> fetchUserName() async {
    final response = await client.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['statusCode'] == 200) {
        return responseData['data']['name']; // Extract and return the name
      } else {
        throw Exception('Failed to fetch user data');
      }
    } else {
      throw Exception('Failed to fetch user data');
    }
  }
}
