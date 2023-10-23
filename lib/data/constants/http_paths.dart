class HttpPaths {
  HttpPaths._();
  static String get _weatherBase => 'https://api.meteomatics.com/';
  static String get getWeatherAuth => '$_weatherBase/api/v1/token';
  static String getWeatherPath({
    required String formattedStartDate,
    required String formattedEndDate,
    required int altitude,
    required double lng,
    required double lat,
  }) =>
      '$_weatherBase/$formattedStartDate--$formattedEndDate:P1D/t_$altitude:F,weather_symbol_24h:idx/$lat,$lng/json';
}
