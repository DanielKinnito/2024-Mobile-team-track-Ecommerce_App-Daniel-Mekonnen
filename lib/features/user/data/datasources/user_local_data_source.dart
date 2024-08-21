import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalDataSource {
  Future<void> deleteAccessToken();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  SharedPreferences sharedPreferences;
  UserLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> deleteAccessToken() async {
    await sharedPreferences.remove('access_token');
  }
}
