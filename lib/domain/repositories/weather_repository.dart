import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_cleanarch/core/errors/failure.dart';
import 'package:flutter_tdd_cleanarch/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String cityName);
}
