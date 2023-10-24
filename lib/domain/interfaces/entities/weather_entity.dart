import 'package:equatable/equatable.dart';

enum WeatherDescription {
  unknown('Unknown', 'assets/sun.png', 'assets/background-sun.jpg'),
  clearSky('Clear Sky', 'assets/sun.png', 'assets/background-sun.jpg'),
  lightClouds('Light Clouds', 'assets/sun.png', 'assets/background-sun.jpg'),
  partlyCloudy('Partly Cloudy', 'assets/cloudy.png', 'assets/background-cloudy.jpg'),
  cloudy('Cloudy', 'assets/cloudy.png', 'assets/background-cloudy.jpg'),
  rain('Rain', 'assets/raining.png', 'assets/background-raining.jpg'),
  rainSnow('Rain Snow', 'assets/raining.png', 'assets/background-raining.jpg'),
  snow('Snow', 'assets/snow.png', 'assets/background-snow.jpg'),
  rainShower('Rain Shower', 'assets/raining.png', 'assets/background-raining.jpg'),
  snowShower('Snow Shower', 'assets/snow.png', 'assets/background-snow.jpg'),
  sleetShower('Sleet Shower', 'assets/raining.png', 'assets/background-raining.jpg'),
  lightFog('Light Fog', 'assets/cloudy.png', 'assets/background-cloudy.jpg'),
  denseFog('Dense Fog', 'assets/cloudy.png', 'assets/background-cloudy.jpg'),
  freezingRain('Freezing Rain', 'assets/snow.png', 'assets/background-snow.jpg'),
  thunderStorms('Thunder Storms', 'assets/raining.png', 'assets/background-raining.jpg'),
  drizzle('Drizzle', 'assets/cloudy.png', 'assets/background-cloudy.jpg'),
  sandstorm('Sandstorm', 'assets/sun.png', 'assets/background-sun.jpg');

  const WeatherDescription(this.description, this.smallIcon, this.backgroundImage);
  final String description;
  final String smallIcon;
  final String backgroundImage;

  factory WeatherDescription.fromCode(int? code) {
    switch (code) {
      case 1:
        return WeatherDescription.clearSky;
      case 2:
        return WeatherDescription.lightClouds;
      case 3:
        return WeatherDescription.partlyCloudy;
      case 4:
        return WeatherDescription.cloudy;
      case 5:
        return WeatherDescription.rain;
      case 6:
        return WeatherDescription.rainSnow;
      case 7:
        return WeatherDescription.snow;
      case 8:
        return WeatherDescription.rainShower;
      case 9:
        return WeatherDescription.snowShower;
      case 10:
        return WeatherDescription.sleetShower;
      case 11:
        return WeatherDescription.lightFog;
      case 12:
        return WeatherDescription.denseFog;
      case 13:
        return WeatherDescription.freezingRain;
      case 14:
        return WeatherDescription.thunderStorms;
      case 15:
        return WeatherDescription.drizzle;
      case 16:
        return WeatherDescription.sandstorm;
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
