import 'package:intl/intl.dart';

class HttpPaths {
  HttpPaths._();
  static final formatter = DateFormat('yyyy-MM-ddThh:mm:ss');
  static String get weatherUser => 'rarolabs_lima_lucas';
  static String get weatherPassword => 'Ik8Oa5qeX9'; // TEST CREDENTIAL ONLY

  static String get _weatherBase => 'https://api.meteomatics.com';
  static String get getWeatherAuth => '$_weatherBase/api/v1/token';
  static String getWeatherPath({
    required DateTime date,
    required int altitude,
    required double lng,
    required double lat,
  }) {
    final formattedStartDate = formatter.format(date);
    final formattedEndDate = formatter.format(date.add(const Duration(days: 4)));
    return '$_weatherBase/${formattedStartDate}Z--${formattedEndDate}Z:P1D/t_$altitude:F,weather_symbol_24h:idx/$lat,$lng/json';
  }
}
