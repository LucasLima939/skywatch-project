import 'package:flutter/material.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({super.key});

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
