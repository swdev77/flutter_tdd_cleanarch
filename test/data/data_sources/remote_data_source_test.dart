import 'package:flutter_tdd_cleanarch/core/constants/constants.dart';
import 'package:flutter_tdd_cleanarch/data/models/weather_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tdd_cleanarch/data/data_sources/weather_remote_data_source_impl.dart';
import 'package:flutter_tdd_cleanarch/core/errors/exception.dart';
import '../../helpers/json_reader.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;
  const testCityName = 'New York';

  setUp(() {
    mockHttpClient = MockHttpClient();
    weatherRemoteDataSourceImpl =
        WeatherRemoteDataSourceImpl(client: mockHttpClient);
  });
  group('get current weather', () {
    test('should return weather model when the response code is 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse(Urls.currentWeatherByName(testCityName))))
          .thenAnswer(
        (_) async => http.Response(
            readJson('helpers/dummy_data/dummy_weather_response.json'), 200),
      );

      // act
      final result =
          await weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);

      // assert
      expect(result, isA<WeatherModel>());
    });

    test(
        'should throw a server exception when the response code is 404 or other',
        () {
      // arrange
      when(mockHttpClient
              .get(Uri.parse(Urls.currentWeatherByName(testCityName))))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      // act
      final result =
          weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);

      // assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });
}
