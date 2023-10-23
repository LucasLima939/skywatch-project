import 'package:equatable/equatable.dart';

enum WeatherDescription {
  unknown,
  clearSky('Clear Sky'),
  lightClouds('Light Clouds'),
  partlyCloudy('Partly Cloudy'),
  cloudy('Cloudy'),
  rain('Rain'),
  rainSnow('Rain Snow'),
  snow('Snow'),
  rainShower('Rain Shower'),
  snowShower('Snow Shower'),
  sleetShower('Sleet Shower'),
  lightFog('Light Fog'),
  denseFog('Dense Fog'),
  freezingRain('Freezing Rain'),
  thunderStorms('Thunder Storms'),
  drizzle('Drizzle'),
  sandstorm('Sandstorm'); //TODO: ADD ASSET PATH

  const WeatherDescription([this.description = 'unknown', this.assetPath]);
  final String description;
  final String? assetPath;

  factory WeatherDescription.fromCode(int? code){
    switch (code) {
      case 1: return WeatherDescription.clearSky;
      case 2: return WeatherDescription.lightClouds;
      case 3: return WeatherDescription.partlyCloudy;
      case 4: return WeatherDescription.cloudy;
      case 5: return WeatherDescription.rain;
      case 6: return WeatherDescription.rainSnow;
      case 7: return WeatherDescription.snow;
      case 8: return WeatherDescription.rainShower;
      case 9: return WeatherDescription.snowShower;
      case 10: return WeatherDescription.sleetShower;
      case 11: return WeatherDescription.lightFog;
      case 12: return WeatherDescription.denseFog;
      case 13: return WeatherDescription.freezingRain;
      case 14: return WeatherDescription.thunderStorms;
      case 15: return WeatherDescription.drizzle;
      case 16: return WeatherDescription.sandstorm;
      default:
        return WeatherDescription.unknown;
    }
  }
}

abstract class WeatherEntity extends Equatable {
  final WeatherDescription description;
  final double temperature;
  final DateTime? date;
  const WeatherEntity({
    required this.date,
    required this.description,
    required this.temperature,
  });

  @override
  List<Object?> get props => [
    description,
    temperature,
    date,
  ];
}
