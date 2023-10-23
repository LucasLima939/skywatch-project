import 'package:skywatch_application/data/models/models.dart';
import 'package:skywatch_application/domain/interfaces/entities/entities.dart';

class ForecastModel extends ForecastEntity {
  const ForecastModel({required super.entities});
  ForecastModel.empty() : super(entities: <WeatherEntity>[]);
  ForecastModel.fromJson(Map<String, dynamic> json, {List<int>? descriptions})
      : super(
            entities: json['dates']?.isNotEmpty == true
                ? List<WeatherEntity>.generate(descriptions?.length ?? json['dates'].length,
                    (index) => WeatherModel.fromJson(json['dates'][index], descriptionCode: descriptions?[index]))
                : <WeatherEntity>[]);
}
