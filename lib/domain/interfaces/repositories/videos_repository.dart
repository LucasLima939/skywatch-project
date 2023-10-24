import 'dart:io';

import 'package:skywatch_application/domain/interfaces/interfaces.dart';

abstract class VideosRepository {
  Future<SkyVideoResponseEntity> readEntities();
  Future<bool> writeEntity(SkyVideoEntity entity);
  Future<String> uploadVideo(File file, String fileName);
  Future<String?> getUserAnonymousId();
  Future<bool> likeVideo(SkyVideoEntity entity);
  Future<File?> getVideo({bool shouldRecord = false, int maxMinutes = 10});
}