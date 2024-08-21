import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/features/user/data/datasources/user_local_data_source.dart';

import '../../helpers/user_mocks.mocks.dart'; // Adjust the import based on your actual project structure

void main() {
  late UserLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        UserLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('UserLocalDataSourceImpl', () {
    test('should remove access token from SharedPreferences', () async {
      // Arrange
      when(mockSharedPreferences.remove('access_token'))
          .thenAnswer((_) async => true);

      // Act
      await dataSource.deleteAccessToken();

      // Assert
      verify(mockSharedPreferences.remove('access_token')).called(1);
    });

    test('should handle exception when removing access token fails', () async {
      // Arrange
      when(mockSharedPreferences.remove('access_token'))
          .thenThrow(Exception('Failed to remove'));

      // Act
      try {
        await dataSource.deleteAccessToken();
        fail('Exception should have been thrown');
      } catch (e) {
        // Assert
        expect(e.toString(), contains('Exception: Failed to remove'));
      }
    });
  });
}
