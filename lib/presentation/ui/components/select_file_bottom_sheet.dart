import 'package:flutter/material.dart';

class SelectFileBottomSheet extends StatelessWidget {
  final void Function(bool shouldRecord) onSelectOption;
  const SelectFileBottomSheet({required this.onSelectOption, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    FocusScope.of(context).unfocus();
                    onSelectOption(true);
                  },
                  title: Text('Record from Camera',
                      style: TextStyle(
                        color: Theme.of(context).appBarTheme.backgroundColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                const Divider(),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    FocusScope.of(context).unfocus();
                    onSelectOption(false);
                  },
                  title: Text('Select from gallery',
                      style: TextStyle(
                        color: Theme.of(context).appBarTheme.backgroundColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
