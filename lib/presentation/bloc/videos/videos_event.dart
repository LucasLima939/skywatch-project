import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';

abstract class VideosEvent extends Equatable {
  const VideosEvent();

  @override
  List<Object?> get props => [];
}

class GetVideoResponseEvent extends VideosEvent {
  const GetVideoResponseEvent();
}

class UploadVideoEvent extends VideosEvent {
  final File file;
  final String fileName;
  const UploadVideoEvent(this.file, this.fileName);

  @override
  List<Object?> get props => [file, fileName];
}

class SubmitVideoEvent extends VideosEvent {
  final SkyVideoEntity entity;
  const SubmitVideoEvent(this.entity);

  @override
  List<Object?> get props => [entity];
}

class LikeVideoEvent extends VideosEvent {
  final SkyVideoEntity entity;
  final bool liked;
  const LikeVideoEvent(this.entity, {required this.liked});

  @override
  List<Object?> get props => [entity, liked];
}

class GetVideoFileEvent extends VideosEvent {
  final bool shouldRecord;
  const GetVideoFileEvent(this.shouldRecord);

  @override
  List<Object?> get props => [shouldRecord];
}

class ClearVideoFileEvent extends VideosEvent {
  const ClearVideoFileEvent();
}

