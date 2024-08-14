import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/core/network/network_info.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
void main() {
  late NetworkInfoImpl networkInfoImpl;
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(mockInternetConnectionChecker);
  });

  test('should forward the call to InternetConnectionChecker.hasConnection',
      () async {
    const tHasConnection = true;
    // arrange
    when(mockInternetConnectionChecker.hasConnection)
        .thenAnswer((_) async => tHasConnection);

    // act
    final result = await networkInfoImpl.isConnected; // await the result

    // assert
    expect(result, tHasConnection); // compare the boolean value
    verify(mockInternetConnectionChecker.hasConnection);
    verifyNoMoreInteractions(mockInternetConnectionChecker);
  });

  test('should return false when there is no connection', () async {
    final tHasNoConnectionFuture = Future.value(false);
    // arrange
    when(mockInternetConnectionChecker.hasConnection)
        .thenAnswer((_) => tHasNoConnectionFuture);
    // act
    final result = networkInfoImpl.isConnected;
    // assert
    expect(result, tHasNoConnectionFuture);
    verify(mockInternetConnectionChecker.hasConnection);
    verifyNoMoreInteractions(mockInternetConnectionChecker);
  });

  test('should always return a Future<bool>', () async {
    // arrange
    when(mockInternetConnectionChecker.hasConnection)
        .thenAnswer((_) => Future.value(true));
    // act
    final result = networkInfoImpl.isConnected;
    // assert
    expect(result, isA<Future<bool>>());
  });
}
