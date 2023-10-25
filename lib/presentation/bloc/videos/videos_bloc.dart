import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';
import 'package:skywatch_application/domain/use_cases/use_cases.dart';

import 'videos.dart';

class VideosBloc extends Bloc<VideosEvent, VideosStates> {
  final GetVideoResponseUseCase getVideoResponseUseCase;
  final GetVideoUseCase getVideoUseCase;
  final LikeVideoUseCase likeVideoUseCase;
  final RemoveLikeVideoUseCase removeLikeVideoUseCase;
  final UploadVideoUseCase uploadVideoUseCase;
  final WriteEntityUseCase writeEntityUseCase;
  VideosBloc(
    this.getVideoResponseUseCase,
    this.getVideoUseCase,
    this.likeVideoUseCase,
    this.removeLikeVideoUseCase,
    this.uploadVideoUseCase,
    this.writeEntityUseCase,
  ) : super(const VideosIdleStates()) {
    on<GetVideoResponseEvent>(_onGetVideoResponse);
    on<UploadVideoEvent>(_onUploadVideo);
    on<SubmitVideoEvent>(_onSubmitVideoEvent);
    on<LikeVideoEvent>(_onLikeVideoEvent);
    on<GetVideoFileEvent>(_onGetVideoFile);
    on<ClearVideoFileEvent>(_onClearVideoFileEvent);
  }

  FutureOr<void> _onGetVideoResponse(GetVideoResponseEvent event, Emitter<VideosStates> emit) async {
    emit(const VideoLoadingState());

    final response = await getVideoResponseUseCase(NoParams());

    response.fold(
        (failure) => emit(VideoFailureState(failure, event)), (videos) => emit(GetVideosResponseStates(videos)));
  }

  FutureOr<void> _onUploadVideo(UploadVideoEvent event, Emitter<VideosStates> emit) async {
    emit(const VideoLoadingState());

    final name = '${DateTime.now().millisecondsSinceEpoch}-${event.fileName}';

    final response = await uploadVideoUseCase.call(UploadVideoParam(file: event.file, fileName: name));

    response.fold((failure) => emit(VideoFailureState(failure, event)), (url) => emit(DownloadVideoSuccessState(url)));
  }

  FutureOr<void> _onSubmitVideoEvent(SubmitVideoEvent event, Emitter<VideosStates> emit) async {
    emit(const VideoLoadingState());

    final response = await writeEntityUseCase(event.entity);

    response.fold((failure) => emit(VideoFailureState(failure, event)), (r) => emit(const SubmitVideoSuccessState()));
  }

  FutureOr<void> _onLikeVideoEvent(LikeVideoEvent event, Emitter<VideosStates> emit) async {
    if (event.liked) {
      await likeVideoUseCase(event.entity);
    } else {
      await removeLikeVideoUseCase(event.entity);
    }
  }

  FutureOr<void> _onClearVideoFileEvent(ClearVideoFileEvent event, Emitter<VideosStates> emit) async {
    emit(const VideosIdleStates());

    emit(const VideoFileResponseState(null));
  }

  FutureOr<void> _onGetVideoFile(GetVideoFileEvent event, Emitter<VideosStates> emit) async {
    emit(const VideoLoadingState());

    final response = await getVideoUseCase(event.shouldRecord);

    await response.fold((failure) async => emit(VideoFailureState(failure)), (file) async {
      if (file != null) {
        emit(VideoFileResponseState(file));
      } else {
        emit(const VideosIdleStates());
      }
    });
  }
}
