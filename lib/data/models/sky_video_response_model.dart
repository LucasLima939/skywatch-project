import 'package:skywatch_application/data/models/models.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';

class SkyVideoResponseModel extends SkyVideoResponseEntity {
  SkyVideoResponseModel.fromJson(Map<String, dynamic> json)
      : super(entities: json['data'].map((j) => SkyVideoModel.fromJson(j)).toList());
  const SkyVideoResponseModel({required super.entities});
}
