import 'package:flutter/material.dart';

class DefaultEmptyPlaceholder extends StatelessWidget {
  final VoidCallback onRefresh;
  const DefaultEmptyPlaceholder({
    super.key,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) => Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text('No data found', style: TextStyle(color: Colors.white, fontSize: 16)),
        const SizedBox(height: 20),
        FilledButton(onPressed: onRefresh, child: const Text('Refresh')),
      ]));
}
