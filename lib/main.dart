import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd_cleanarch/injection_container.dart';
import 'package:flutter_tdd_cleanarch/presentation/bloc/weather_bloc.dart';
import 'package:flutter_tdd_cleanarch/presentation/pages/weather_page.dart';

void main() {
  setUpLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => locator<WeatherBloc>(),
        )
      ],
      child: const MaterialApp(
        home: WeatherPage(),
      ),
    );
  }
}
