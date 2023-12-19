import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_cleanarch/domain/entities/weather.dart';

import '../../core/errors/failure.dart';
import '../repositories/weather_repository.dart';

class GetCurrentWeatherUseCase {
  final WeatherRepository _weatherRepository;

  GetCurrentWeatherUseCase(this._weatherRepository);

  Future<Either<Failure, WeatherEntity>> execute(String cityName) async {
    return await _weatherRepository.getCurrentWeather(cityName);
  }
}
