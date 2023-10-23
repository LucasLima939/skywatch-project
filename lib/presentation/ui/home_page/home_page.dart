import 'package:flutter/material.dart';
import 'package:skywatch_application/presentation/bloc/weather/weather.dart';

class HomePage extends StatefulWidget {
  final WeatherBloc weatherBloc;
  const HomePage({
    super.key,
    required this.weatherBloc,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
