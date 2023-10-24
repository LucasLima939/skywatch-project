import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';

class WeeklyForecastTile extends StatelessWidget {
  final List<WeatherEntity> entities;
  const WeeklyForecastTile(this.entities, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 29),
      child: ExpansionTile(
        backgroundColor: Theme.of(context).primaryColor,
        collapsedBackgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        title: SizedBox(
            height: 105,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.sunny, color: Theme.of(context).primaryColor),
                ),
                const SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Next four days',
                        style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 2),
                    Text('see detailed forecast',
                        style: TextStyle(fontSize: 14, color: Theme.of(context).scaffoldBackgroundColor)),
                  ],
                ),
              ],
            )),
        children: [
          const Divider(),
          ...entities.map((e) => _weatherTile(e, context)).toList(),
        ],
      ),
    );
  }

  Widget _weatherTile(WeatherEntity entity, context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(
                entity.description.smallIcon,
                height: 20,
                width: 20,
              ),
            ),
            const SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (entity.date != null)
                  Text(DateFormat.yMEd().format(entity.date!),
                      style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text('${entity.temperature.toInt()}ºF',
                    style: TextStyle(fontSize: 14, color: Theme.of(context).scaffoldBackgroundColor)),
                const SizedBox(height: 2),
                Text(entity.description.description,
                    style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w700)),
              ],
            )
          ],
        ),
      );
}