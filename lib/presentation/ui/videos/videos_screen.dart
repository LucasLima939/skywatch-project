import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';
import 'package:skywatch_application/presentation/bloc/videos/videos.dart';
import 'package:skywatch_application/presentation/bloc/weather/weather.dart';
import 'package:skywatch_application/presentation/ui/components/components.dart';
import 'package:skywatch_application/presentation/ui/videos/videos.dart';

class VideosScreen extends StatefulWidget {
  final VideosBloc videosBloc;
  final WeatherBloc weatherBloc;
  const VideosScreen(this.videosBloc, this.weatherBloc, {super.key});

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  SkyVideoResponseEntity? videos;
  late bool isLoading;

  @override
  void initState() {
    _initVideosPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<VideosBloc, VideosStates>(
          bloc: widget.videosBloc,
          builder: (context, state) {
            isLoading = false;
            if (state is GetVideosResponseStates) {
              videos = state.entity;
            } else if (state is VideoLoadingState) {
              isLoading = true;
            }

            return isLoading
                ? const Center(child: CircularProgressIndicator(color: Colors.white))
                : videos?.entities.isNotEmpty == true
                    ? Column(children: [
                        VideosResultHeader(videos!.entities.length),
                        VideoResultBody(videos!.entities, onRefresh: _initVideosPage),
                      ])
                    : DefaultEmptyPlaceholder(onRefresh: _initVideosPage);
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () async => await _openUploadBottomSheet().then((isSuccess) {
          if (isSuccess == true) _initVideosPage();
        }),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Future _openUploadBottomSheet() => showDialog(
      context: context,
      builder: (context) => UploadVideoBottomSheet(
            widget.videosBloc,
            widget.weatherBloc,
          ));

  Future<void> _initVideosPage() async => widget.videosBloc.add(const GetVideoResponseEvent());
}
