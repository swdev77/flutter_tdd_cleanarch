import 'package:flutter_tdd_cleanarch/data/models/weather_model.dart';
import 'package:flutter_tdd_cleanarch/domain/entities/weather.dart';

const testCityName = 'New York';

const testWeatherEntity = WeatherEntity(
  cityName: 'New York',
  main: 'Cloudy',
  description: 'few clouds',
  iconCode: '02d',
  temperature: 10,
  pressure: 1009,
  humidity: 70,
);

const testWeatherModel = WeatherModel(
  cityName: 'New York',
  main: 'Cloudy',
  description: 'few clouds',
  iconCode: '02d',
  temperature: 10,
  pressure: 1009,
  humidity: 70,
);
