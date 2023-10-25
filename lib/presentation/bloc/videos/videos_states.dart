import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';

abstract class VideosStates extends Equatable {
  const VideosStates();

  @override
  List<Object?> get props => [];
}

class VideosIdleStates extends VideosStates {
  const VideosIdleStates();
}

class GetVideosResponseStates extends VideosStates {
  final SkyVideoResponseEntity entity;
  const GetVideosResponseStates(this.entity);

  @override
  List<Object?> get props => [entity];
}

class VideoFileResponseState extends VideosStates {
  final File? file;
  const VideoFileResponseState(this.file);

  @override
  List<Object?> get props => [file];
}

class VideoFailureState extends VideosStates {
  final Failure failure;
  final dynamic refreshEvent;
  const VideoFailureState(this.failure, [this.refreshEvent]);

  @override
  List<Object?> get props => [failure, refreshEvent];
}

class DownloadVideoSuccessState extends VideosStates {
  final String downloadUrl;
  const DownloadVideoSuccessState(this.downloadUrl);

  @override
  List<Object?> get props => [downloadUrl];
}

class SubmitVideoSuccessState extends VideosStates {
  const SubmitVideoSuccessState();
}

class VideoLoadingState extends VideosStates {
  const VideoLoadingState();
}