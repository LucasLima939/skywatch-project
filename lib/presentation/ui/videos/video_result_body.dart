
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';

class VideoResultBody extends StatefulWidget {
  final List<SkyVideoEntity> entities;
  const VideoResultBody(this.entities, {super.key});

  @override
  State<VideoResultBody> createState() => _VideoResultBodyState();
}

class _VideoResultBodyState extends State<VideoResultBody> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15),
              if (widget.entities.isNotEmpty) ..._buildListCard(widget.entities),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildListCard(List<SkyVideoEntity> entities) => entities.map((e) => _buildCard(e)).toList();

  Widget _buildCard(SkyVideoEntity entity) => ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          height: MediaQuery.of(context).size.height * .4,
          constraints: const BoxConstraints(
            maxHeight: 500,
            minHeight: 300,
          ),
          margin: const EdgeInsets.only(bottom: 10),
          child: Card(
            color: Theme.of(context).appBarTheme.backgroundColor,
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
            child: Column(
              children: [
                Expanded(
                    child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.asset(
                    'assets/background-snow.jpg',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
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
                          Text(entity.locationAbbreviation,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,
                              )),
                        ],
                      ),
                      if (entity.description != null)
                        Text(entity.description!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            )),
                      if (entity.date != null)
                        Text(DateFormat.yMEd().format(entity.date!),
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
