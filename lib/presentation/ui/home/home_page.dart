import 'package:flutter/material.dart';
import 'package:skywatch_application/presentation/bloc/weather/weather.dart';
import 'package:skywatch_application/presentation/ui/ui.dart';

class HomePage extends StatefulWidget {
  final WeatherBloc weatherBloc;
  const HomePage({
    super.key,
    required this.weatherBloc,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              title: Text('SkyWatch', style: Theme.of(context).textTheme.titleLarge),
              centerTitle: true,
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            ),
          ),
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            VideosScreen(),
            WeatherScreen(),
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
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
                  BottomNavigationBarItem(icon: Icon(Icons.sunny), label: '')
                ],
              ),
            )));
  }
}
