import 'package:flutter/material.dart';
import 'package:skywatch_application/presentation/bloc/videos/videos.dart';
import 'package:skywatch_application/presentation/bloc/weather/weather.dart';
import 'package:skywatch_application/presentation/ui/components/components.dart';
import 'package:skywatch_application/presentation/ui/ui.dart';

class HomePage extends StatefulWidget {
  final WeatherBloc weatherBloc;
  final VideosBloc videosBloc;
  const HomePage({
    super.key,
    required this.weatherBloc,
    required this.videosBloc,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PageController pageController;
  int currentIndex = 0;

  @override
  void initState() {
    pageController = PageController(initialPage: currentIndex);
    widget.weatherBloc.add(const GetCurrentLocationEvent());
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: const BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10)],
            ),
            child: AppBar(
              leading: Container(),
              title: Text('SkyWatch', style: Theme.of(context).textTheme.titleLarge),
              centerTitle: true,
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            ),
          ),
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [
            VideosScreen(widget.videosBloc, widget.weatherBloc, openUploadBottomSheet: _openUploadBottomSheet),
            WeatherScreen(widget.weatherBloc),
          ],
        ),
        bottomNavigationBar: Container(
            height: 85,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              boxShadow: [BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10)],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
              child: BottomNavigationBar(
                elevation: 20,
                backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                selectedItemColor: Theme.of(context).primaryColor,
                unselectedItemColor: Theme.of(context).disabledColor,
                iconSize: 33,
                currentIndex: currentIndex,
                onTap: (index) {
                  setState(() => currentIndex = index);
                  pageController.animateToPage(index,
                      duration: const Duration(milliseconds: 200), curve: Curves.linear);
                },
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
                  BottomNavigationBarItem(icon: Icon(Icons.sunny), label: '')
                ],
              ),
            )));
  }

  Future _openUploadBottomSheet() => showDialog(
      context: context,
      builder: (context) => UploadVideoBottomSheet(
            widget.videosBloc,
            widget.weatherBloc,
          ));
}
