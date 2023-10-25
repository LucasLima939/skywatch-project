import 'package:flutter/material.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';
import 'package:skywatch_application/presentation/ui/videos/videos.dart';

class VideoResultBody extends StatefulWidget {
  final List<SkyVideoEntity> entities;
  final Future<void> Function() onRefresh;
  const VideoResultBody(this.entities, {required this.onRefresh, super.key});

  @override
  State<VideoResultBody> createState() => _VideoResultBodyState();
}

class _VideoResultBodyState extends State<VideoResultBody> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: RefreshIndicator(
            onRefresh: widget.onRefresh,
            child: ListView.builder(
                itemCount: widget.entities.length,
                addAutomaticKeepAlives: false,
                itemBuilder: (context, index) => VideoCard(widget.entities[index]))),
      ),
    );
  }
}
