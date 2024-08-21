import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/features/user/data/models/user_model.dart';
import 'package:myapp/features/user/domain/entities/user.dart';

void main() {
  const tUserModel = UserModel(
    id: '1',
    name: 'John Doe',
    email: 'john.doe@example.com',
    password: 'password123',
  );

  const tUser = User(
    id: '1',
    name: 'John Doe',
    email: 'john.doe@example.com',
    password: 'password123',
  );

  group('UserModel', () {
    test('should be a subclass of User entity', () async {
      // Assert
      expect(tUserModel, isA<User>());
    });

    group('fromJson', () {
      test('should return a valid model from JSON', () {
        // Arrange
        final Map<String, dynamic> jsonMap = {
          'id': '1',
          'name': 'John Doe',
          'email': 'john.doe@example.com',
          'password': 'password123',
        };

        // Act
        final result = UserModel.fromJson(jsonMap);

        // Assert
        expect(result, tUserModel);
      });
    });

    group('toJson', () {
      test('should return a JSON map containing the proper data', () {
        // Act
        final result = tUserModel.toJson();

        // Assert
        final expectedMap = {
          'id': '1',
          'name': 'John Doe',
          'email': 'john.doe@example.com',
          'password': 'password123',
        };
        expect(result, expectedMap);
      });
    });

    group('fromEntity', () {
      test('should return a valid model from an entity', () {
        // Act
        final result = UserModel.fromEntity(tUser);

        // Assert
        expect(result, tUserModel);
      });
    });

    group('toEntity', () {
      test('should return a valid entity from a model', () {
        // Act
        final result = tUserModel.toEntity();

        // Assert
        expect(result, tUser);
      });
    });

    group('props', () {
      test('should return a list of properties', () {
        // Act
        final result = tUserModel.props;

        // Assert
        expect(result, [
          tUserModel.id,
          tUserModel.name,
          tUserModel.email,
          tUserModel.password
        ]);
      });
    });
  });
}
