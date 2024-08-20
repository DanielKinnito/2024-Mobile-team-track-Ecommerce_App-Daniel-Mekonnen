import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/features/user/data/models/user_model.dart';
import 'package:myapp/features/user/domain/entities/user.dart';

void main() {
  // Create a test instance of UserModel
  var testUserModel = const UserModel(
    id: '12345',
    name: 'John Doe',
    email: 'john.doe@example.com',
    password: 'password123',
  );

  // Test JSON data for UserModel
  final testJson = {
    'id': '12345',
    'name': 'John Doe',
    'email': 'john.doe@example.com',
    'password': 'password123',
  };

  group('UserModel', () {
    test('should be a subclass of User entity', () async {
      // Assert
      expect(testUserModel, isA<User>());
    });

    test('should correctly convert to JSON', () async {
      // Act
      final result = testUserModel.toJson();
      // Assert
      expect(result, testJson);
    });

    test('should correctly convert from JSON', () async {
      // Act
      final Map<String, dynamic> jsonMap = testJson;
      final result = UserModel.fromJson(jsonMap);
      // Assert
      expect(result, testUserModel);
    });

    test('should correctly convert from User entity to UserModel', () async {
      // Act
      final result = UserModel.fromEntity(testUserModel.toEntity());
      // Assert
      expect(result, testUserModel);
    });

    test('should correctly convert from UserModel to User entity', () async {
      // Act
      final result = testUserModel.toEntity();
      // Assert
      expect(result, isA<User>());
      expect(result.id, testUserModel.id);
      expect(result.name, testUserModel.name);
      expect(result.email, testUserModel.email);
      expect(result.password, testUserModel.password);
    });
  });
}
