import 'package:equatable/equatable.dart';

abstract class SkyVideoEntity extends Equatable {
  final String downloadUrl;
  final String? description;
  final List<String> likes;
  final String locationAbbreviation;
  final String weatherTag;
  final DateTime? date;
  final String? ownerUid;
  final String uid;
  const SkyVideoEntity({
    required this.downloadUrl,
    required this.likes,
    required this.locationAbbreviation,
    required this.weatherTag,
    required this.ownerUid,
    required this.uid,
    this.date,
    this.description,
  });

  Map<String, dynamic> toJson(String ownerId);

  @override
  List<Object?> get props => [
    downloadUrl,
    description,
    likes,
    locationAbbreviation,
    weatherTag,
    ownerUid,
    uid,
  ];
}
