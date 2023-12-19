import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_cleanarch/core/errors/exception.dart';
import 'package:flutter_tdd_cleanarch/core/errors/failure.dart';
import 'package:flutter_tdd_cleanarch/data/data_sources/remote_data_source.dart';
import 'package:flutter_tdd_cleanarch/domain/entities/weather.dart';
import 'package:flutter_tdd_cleanarch/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  WeatherRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(
      String cityName) async {
    try {
      final result = await remoteDataSource.getCurrentWeather(cityName);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('An error occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
