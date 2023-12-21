import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_cleanarch/core/errors/failure.dart';
import 'package:flutter_tdd_cleanarch/presentation/bloc/weather_bloc.dart';
import 'package:flutter_tdd_cleanarch/presentation/bloc/weather_event.dart';
import 'package:flutter_tdd_cleanarch/presentation/bloc/weather_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_constants.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    weatherBloc = WeatherBloc(mockGetCurrentWeatherUseCase);
  });

  test('initial state should be empty', () {
    expect(weatherBloc.state, WeatherEmpty());
  });

  blocTest<WeatherBloc, WeatherState>(
      'should emit [WeatherLoading, WeatherLoaded] when data is gotten successfully',
      build: () {
        when(mockGetCurrentWeatherUseCase.execute(testCityName))
            .thenAnswer((_) async => const Right(testWeatherEntity));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
            WeatherLoading(),
            const WeatherLoaded(testWeatherEntity),
          ]);

  blocTest(
    'should emit [WeatherLoading, WeatherLoadFailure] when data is gotten unsuccessfully',
    build: () {
      when(mockGetCurrentWeatherUseCase.execute(testCityName))
          .thenAnswer((_) async => const Left(ServerFailure('Server failure')));
      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WeatherLoading(),
      const WeatherLoadFailure('Server failure'),
    ],
  );
}
