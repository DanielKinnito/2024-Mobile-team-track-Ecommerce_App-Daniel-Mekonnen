import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../../core/constants/constants.dart';
import '../../../../core/exception/exception.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> loginUser(String email, String password);
  Future<UserModel> registerUser(String email, String password, String name);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> loginUser(String email, String password) async {
    final response = await client.post(
      Uri.parse(UserUrls.loginUser()),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return UserModel.fromJson(data['data']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> registerUser(
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

    if (response.statusCode == 201) {
      final Map<String, dynamic> data = json.decode(response.body);
      return UserModel.fromJson(data['data']);
    } else {
      throw ServerException();
    }
  }
}
