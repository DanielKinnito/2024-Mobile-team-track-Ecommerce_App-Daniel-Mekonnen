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
    final tHasConnectionFuture = Future.value(true);
    // arrange
    when(mockInternetConnectionChecker.hasConnection)
        .thenAnswer((_) => tHasConnectionFuture);
    // act
    final result = networkInfoImpl.isConnected;
    // assert
    expect(result, tHasConnectionFuture);
    verify(mockInternetConnectionChecker.hasConnection);
    verifyNoMoreInteractions(mockInternetConnectionChecker);
  });
}
