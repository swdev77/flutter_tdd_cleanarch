import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_cleanarch/core/errors/exception.dart';
import 'package:flutter_tdd_cleanarch/core/errors/failure.dart';
import 'package:flutter_tdd_cleanarch/data/repositories/weather_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../helpers/test_constants.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;

  setUp(() {
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    weatherRepositoryImpl =
        WeatherRepositoryImpl(remoteDataSource: mockWeatherRemoteDataSource);
  });

  group('Weather repository', () {
    test(
        'should return current weather when a call to data source is successful',
        () async {
      // arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
          .thenAnswer((_) async => testWeatherModel);

      // act
      final result =
          await weatherRepositoryImpl.getCurrentWeather(testCityName);

      // assert
      expect(result, equals(const Right(testWeatherEntity)));
    });

    test('should return failure when a call to data source is unsuccessful',
        () async {
      // arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
          .thenThrow(ServerException());

      // act
      final result =
          await weatherRepositoryImpl.getCurrentWeather(testCityName);

      // assert
      expect(result, equals(const Left(ServerFailure('An error occurred'))));
    });

    test(
        'should return connection failure when the device has no internet connection',
        () async {
      // arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
          .thenThrow(const SocketException('Failed to connect to the network'));

      // act
      final result =
          await weatherRepositoryImpl.getCurrentWeather(testCityName);

      // assert
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });
}
