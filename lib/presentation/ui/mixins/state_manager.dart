import 'package:flutter/material.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';

mixin StateManager {
  showFailureDialog(Failure failure, BuildContext context, [void Function()? refreshEvent]) =>
      showDialog(context: context, builder: (context) => FailureDialog(refreshEvent));
}

class FailureDialog extends StatelessWidget {
  final void Function()? refreshEvent;
  const FailureDialog(this.refreshEvent, {super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              height: MediaQuery.of(context).size.height * .3,
              width: MediaQuery.of(context).size.width * .7,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close, color: Theme.of(context).primaryColor)),
                  Center(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const Text('An error occurred', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    _buildButton(context),
                  ])),
                ],
              ),
            ),
          ),
        ),
      );

  Widget _buildButton(BuildContext context) => Container(
        padding: const EdgeInsets.only(top: 40),
        height: 80,
        width: MediaQuery.of(context).size.width * .5,
        child: FilledButton(
            style: refreshEvent == null ? Theme.of(context).textButtonTheme.style : null,
            onPressed: () {
              Navigator.pop(context);
              if (refreshEvent != null) refreshEvent!();
            },
            child: Text(refreshEvent != null ? 'Refresh' : 'Close')),
      );
}
