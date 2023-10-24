import 'package:intl/intl.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required super.date,
    required super.description,
    required super.temperature,
  });
  const WeatherModel.empty() : super(date: null, description: WeatherDescription.unknown, temperature: 0.0);
  WeatherModel.fromJson(Map<String, dynamic> json, {int? descriptionCode})
      : super(
            date: json['date'] != null ? DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(json['date']) : null,
            description: WeatherDescription.fromCode(descriptionCode),
            temperature: json['value'] ?? 0.0);
}
