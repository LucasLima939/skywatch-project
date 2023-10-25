import 'package:skywatch_application/domain/interfaces/interfaces.dart';
import 'package:uuid/uuid.dart';

class SkyVideoModel extends SkyVideoEntity {
  SkyVideoModel({
    required super.downloadUrl,
    required super.likes,
    required super.locationAbbreviation,
    required super.weatherTag,
    super.ownerUid,
    super.description,
    super.date,
  }) : super(uid: const Uuid().v4());

  SkyVideoModel.fromJson(Map<String, dynamic> json)
      : super(
          downloadUrl: json['url'],
          likes: List<String>.from(json['likes'] ?? []),
          locationAbbreviation: json['locationAbbreviation'],
          weatherTag: json['weatherTag'],
          description: json['description'],
          ownerUid: json['ownerUid'],
          uid: json['uid'],
          date: json['timestamp'] != null ? DateTime.fromMillisecondsSinceEpoch(json['timestamp']) : null,
        );

  @override
  Map<String, dynamic> toJson(String ownerId) => <String, dynamic>{
        'url': downloadUrl,
        'likes': likes,
        'locationAbbreviation': locationAbbreviation,
        'weatherTag': weatherTag,
        'description': description,
        'uid': uid,
        'ownerUid': ownerUid ?? ownerId,
        'timestamp': date?.millisecondsSinceEpoch,
      };
}
