import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';

import 'videos.dart';

class VideoCard extends StatefulWidget {
  final SkyVideoEntity entity;
  const VideoCard(this.entity, {super.key});

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          height: MediaQuery.of(context).size.height * .6,
          constraints: const BoxConstraints(
            maxHeight: 500,
            minHeight: 300,
          ),
          margin: const EdgeInsets.only(top: 15),
          child: Card(
            color: Theme.of(context).appBarTheme.backgroundColor,
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
            child: Column(
              children: [
                Expanded(
                    child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: VideoPlayerComponent(widget.entity.downloadUrl),
                )),
                Container(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.white),
                          const SizedBox(width: 3),
                          Text(widget.entity.locationAbbreviation,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,
                              )),
                        ],
                      ),
                      if (widget.entity.description != null)
                        Text(widget.entity.description!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            )),
                      if (widget.entity.date != null)
                        Text(DateFormat.yMEd().format(widget.entity.date!),
                            style: const TextStyle(
                              color: Color(0xFF96A7AF),
                              fontSize: 8,
                              decoration: TextDecoration.underline,
                            )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
