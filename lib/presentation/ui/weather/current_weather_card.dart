import 'package:flutter/material.dart';
import 'package:skywatch_application/domain/interfaces/entities/entities.dart';

class CurrentWeatherCard extends StatelessWidget {
  final WeatherEntity weatherEntity;
  final AddressEntity? addressEntity;
  const CurrentWeatherCard(this.weatherEntity, this.addressEntity, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 200,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image(
              fit: BoxFit.cover,
              image: AssetImage(weatherEntity.description.backgroundImage),
              height: 200,
              width: 200,
            ),
            Container(
              height: 200,
              width: 200,
              color: const Color(0xCC000000),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      addressEntity?.city ?? 'Unknown Location',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      '${weatherEntity.temperature.toInt().toString()}ºF',
                      style: const TextStyle(color: Colors.white, fontSize: 36),
                    ),
                    Text(
                      weatherEntity.description.description,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}