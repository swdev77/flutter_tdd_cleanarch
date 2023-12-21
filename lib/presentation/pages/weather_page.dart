import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd_cleanarch/core/constants/constants.dart';
import 'package:flutter_tdd_cleanarch/presentation/bloc/weather_bloc.dart';
import 'package:flutter_tdd_cleanarch/presentation/bloc/weather_event.dart';
import 'package:flutter_tdd_cleanarch/presentation/bloc/weather_state.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Weather App',
            style: TextStyle(fontSize: 30),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Enter city name',
                  fillColor: const Color(0xfff5f5f5),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (query) {
                  context.read<WeatherBloc>().add(OnCityChanged(query));
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is WeatherLoaded) {
                    return Column(
                      key: const Key('weather_data'),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(state.result.cityName),
                            // Image(
                            //   image: NetworkImage(
                            //     Urls.weatherIcon(state.result.iconCode),
                            //   ),
                            // ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                            '${state.result.main} | ${state.result.description}'),
                        const SizedBox(height: 24),
                        Table(
                          defaultColumnWidth: const FixedColumnWidth(150),
                          border: TableBorder.all(
                              color: Colors.grey,
                              width: 1,
                              style: BorderStyle.solid),
                          children: [
                            TableRow(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Text('Temperature'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child:
                                      Text(state.result.temperature.toString()),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Text('Pressure'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(state.result.pressure.toString()),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Text('Humidity'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(state.result.humidity.toString()),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                  if (state is WeatherLoadFailure) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ));
  }
}
