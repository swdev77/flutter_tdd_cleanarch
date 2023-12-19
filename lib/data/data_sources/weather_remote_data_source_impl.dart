import 'dart:convert';

import 'package:flutter_tdd_cleanarch/core/errors/exception.dart';
import 'package:flutter_tdd_cleanarch/data/data_sources/remote_data_source.dart';
import 'package:flutter_tdd_cleanarch/data/models/weather_model.dart';
import 'package:http/http.dart';

import '../../core/constants/constants.dart';

class WeatherRemoteDataSourceImpl extends WeatherRemoteDataSource {
  final Client client;
  WeatherRemoteDataSourceImpl({required this.client});
  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName(cityName)));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
