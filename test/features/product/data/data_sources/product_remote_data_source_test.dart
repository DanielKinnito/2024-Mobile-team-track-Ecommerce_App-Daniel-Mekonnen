import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/core/constants/constants.dart';
import 'package:myapp/features/product/data/data_sources/product_remote_data_source.dart';

import '../../helpers/mocks.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late ProductRemoteDataSourceImpl dataSourceImpl;
  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSourceImpl = ProductRemoteDataSourceImpl(client: mockHttpClient);
  });

  const productId = '6672776eb905525c145fe0bb';
  group('getProduct', () async {
    test('should return a product when api call is successful', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(Urls.getProduct(productId)))).thenAnswer(answer)
    });
  });
}
