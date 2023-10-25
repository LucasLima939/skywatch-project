import 'package:flutter/material.dart';
import 'package:skywatch_application/data/models/models.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';
import 'package:skywatch_application/presentation/bloc/videos/videos.dart';
import 'package:skywatch_application/presentation/bloc/weather/weather.dart';
import 'package:skywatch_application/presentation/ui/videos/videos.dart';

class VideosScreen extends StatefulWidget {
  final VideosBloc videosBloc;
  final WeatherBloc weatherBloc;
  final VoidCallback openUploadBottomSheet;
  const VideosScreen(this.videosBloc, this.weatherBloc, {required this.openUploadBottomSheet, super.key});

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  late final entities = List<SkyVideoEntity>.filled(
      6,
      SkyVideoModel(
        downloadUrl: '',
        likes: [],
        locationAbbreviation: 'Unknown',
        weatherTag: 'sunny',
        date: DateTime.now(),
        description: 'Lorem ipsum dolor sit amet, consectetur...',
      ));
  late final SkyVideoResponseEntity videos = SkyVideoResponseModel(entities: entities);

  @override
  void initState() {
    widget.videosBloc.add(const GetVideoResponseEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          VideosResultHeader(videos.entities.length),
          VideoResultBody(videos.entities),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: widget.openUploadBottomSheet,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
