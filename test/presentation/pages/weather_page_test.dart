import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_tdd_cleanarch/presentation/bloc/weather_bloc.dart';
import 'package:flutter_tdd_cleanarch/presentation/bloc/weather_event.dart';
import 'package:flutter_tdd_cleanarch/presentation/bloc/weather_state.dart';
import 'package:flutter_tdd_cleanarch/presentation/pages/weather_page.dart';

import '../../helpers/test_constants.dart';

class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

void main() {
  late MockWeatherBloc mockWeatherBloc;

  setUp(() => mockWeatherBloc = MockWeatherBloc());

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WeatherBloc>(
      create: (context) => mockWeatherBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'text field should trigger state to change from empty to loading',
    (widgetTester) async {
      // arrange
      when(() => mockWeatherBloc.state).thenReturn(WeatherEmpty());

      // act
      await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));
      var textField = find.byType(TextField);

      expect(textField, findsOneWidget);
      await widgetTester.enterText(textField, 'New York');
      await widgetTester.pump();

      expect(find.text('New York'), findsOneWidget);
    },
  );

  testWidgets(
    'should show progress indicator when state is loading',
    (widgetTester) async {
      when(() => mockWeatherBloc.state).thenReturn(WeatherLoading());

      await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets('should show widget contain weather data when state is weather loaded', 
  (widgetTester) async {
    when(() => mockWeatherBloc.state).thenReturn(const WeatherLoaded(testWeatherEntity));

    await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));

    expect(find.byKey(const Key('weather_data')), findsOneWidget);
  });
}
