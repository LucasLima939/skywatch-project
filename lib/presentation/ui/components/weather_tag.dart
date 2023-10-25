import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';
import 'package:skywatch_application/presentation/bloc/weather/weather.dart';

class WeatherTag extends StatefulWidget {
  final TextEditingController weatherController;
  const WeatherTag(this.weatherController, {super.key});

  @override
  State<WeatherTag> createState() => _WeatherTagState();
}

class _WeatherTagState extends State<WeatherTag> {
  late final weatherBloc = Modular.get<WeatherBloc>();
  WeatherEntity? currentWeather;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      bloc: weatherBloc,
      builder: (context, state) {
        if (state is WeatherForecastState) {
          final entities = state.entity.entities;
          if (entities.isNotEmpty) {
            currentWeather = entities.first;
            widget.weatherController.text = currentWeather!.description.description;
          }
        }

        return currentWeather != null
            ? Container(
                padding: const EdgeInsets.all(10),
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      currentWeather!.description.smallIcon,
                      height: 20,
                      width: 20,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 3),
                    Text(widget.weatherController.text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                        )),
                  ],
                ))
            : Container();
      },
    );
  }
}
