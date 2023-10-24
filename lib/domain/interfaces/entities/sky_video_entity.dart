import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class SkyVideoEntity extends Equatable {
  final String downloadUrl;
  final File? uploadFile;
  final String? description;
  final List<String> likes;
  final String locationAbbreviation;
  final String weatherTag;
  final DateTime? date;
  final String? uid;
  const SkyVideoEntity({
    required this.downloadUrl,
    required this.likes,
    required this.locationAbbreviation,
    required this.weatherTag,
    required this.uid,
    this.date,
    this.uploadFile,
    this.description,
  });

  Map<String, dynamic> toJson(String uid);

  @override
  List<Object?> get props => [
    downloadUrl,
    uploadFile,
    description,
    likes,
    locationAbbreviation,
    weatherTag,
  ];
}
