import 'package:skywatch_application/domain/interfaces/interfaces.dart';

class SkyVideoModel extends SkyVideoEntity {
  const SkyVideoModel({
    required super.downloadUrl,
    required super.likes,
    required super.locationAbbreviation,
    required super.weatherTag,
    super.uid,
    super.description,
    super.date,
    super.uploadFile,
  });

  SkyVideoModel.fromJson(Map<String, dynamic> json)
      : super(
          downloadUrl: json['url'],
          likes: json['likes'],
          locationAbbreviation: json['locationAbbreviation'],
          weatherTag: json['weatherTag'],
          description: json['description'],
          uploadFile: null,
          uid: json['uid'],
          date: json['timestamp'] != null ? DateTime.fromMillisecondsSinceEpoch(json['timestamp']) : null,
        );

  @override
  Map<String, dynamic> toJson(String uid) => <String, dynamic>{
        'url': downloadUrl,
        'likes': likes,
        'locationAbbreviation': locationAbbreviation,
        'weatherTag': weatherTag,
        'description': description,
        'uid': uid,
        'timestamp': date?.millisecondsSinceEpoch,
      };
}
