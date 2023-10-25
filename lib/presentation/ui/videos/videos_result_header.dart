import 'package:flutter/material.dart';

class VideosResultHeader extends StatelessWidget {
  final int resultLength;
  const VideosResultHeader(this.resultLength, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Theme.of(context).appBarTheme.backgroundColor,
          boxShadow: const [BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10)],
        ),
        child: Row(
          children: [
            Text('view $resultLength results', style: const TextStyle(color: Colors.white, fontSize: 16)),
            const Spacer(),
            const Text('recent | all', style: TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ));
  }
}
