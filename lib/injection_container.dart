import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_tdd_cleanarch/data/data_sources/remote_data_source.dart';
import 'package:flutter_tdd_cleanarch/data/data_sources/weather_remote_data_source_impl.dart';
import 'package:flutter_tdd_cleanarch/data/repositories/weather_repository_impl.dart';
import 'package:flutter_tdd_cleanarch/domain/repositories/weather_repository.dart';
import 'package:flutter_tdd_cleanarch/domain/usecases/get_current_weather.dart';
import 'package:flutter_tdd_cleanarch/presentation/bloc/weather_bloc.dart';

final locator = GetIt.instance;

void setUpLocator() {
  locator.registerFactory(() => WeatherBloc(locator()));

  locator.registerLazySingleton(() => GetCurrentWeatherUseCase(locator()));

  locator.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(remoteDataSource: locator()),
  );

  locator.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(client: locator()),
  );

  locator.registerLazySingleton(() => http.Client());
}
