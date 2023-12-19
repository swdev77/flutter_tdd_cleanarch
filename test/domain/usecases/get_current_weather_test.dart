import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_cleanarch/domain/entities/weather.dart';
import 'package:flutter_tdd_cleanarch/domain/usecases/get_current_weather.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helpers.mocks.dart';

void main() {
  late GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  late MockWeatherRepository mockWeatherRepository;

  const testWeatherDetail = WeatherEntity(
    cityName: 'New York',
    main: 'Cloudy',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 10,
    pressure: 1009,
    humidity: 70,
  );

  const testCityName = 'New York';

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeatherUseCase = GetCurrentWeatherUseCase(mockWeatherRepository);
  });

  test('should get current weather detail from the repository', () async {
    // arrange
    when(
      mockWeatherRepository.getCurrentWeather(testCityName)
    ).thenAnswer((_) async => const Right(testWeatherDetail));

    // act
    final result = await getCurrentWeatherUseCase.execute(testCityName);

    // assert
    expect(result, const Right(testWeatherDetail));
  });
}
