import 'package:intl/intl.dart';

class HttpPaths {
  HttpPaths._();
  static final formatter = DateFormat('yyyy-MM-ddThh:mm:ss');
  static String get weatherUser => 'teste_teste_teste';
  static String get weatherPassword => 'fK0Um2Z9tS'; // TEST CREDENTIAL ONLY

  static String get getWeatherQuery => 'https://login.meteomatics.com/api/v1/token';
  static String get _weatherBase => 'https://api.meteomatics.com';
  static String getWeatherPath({
    required DateTime date,
    required int altitude,
    required double lng,
    required double lat,
  }) {
    final formattedStartDate = formatter.format(date);
    final formattedEndDate = formatter.format(date.add(const Duration(days: 4)));
    return '$_weatherBase/${formattedStartDate}Z--${formattedEndDate}Z:P1D/t_${altitude}m:F,weather_symbol_24h:idx/$lat,$lng/json';
  }

  static String get _addressBase => 'https://nominatim.openstreetmap.org';
  static String getAddressQuery(double lat, double lng) => '$_addressBase/reverse?lat=$lat&lon=$lng&format=jsonv2';
}
