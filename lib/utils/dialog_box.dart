import 'package:flutter/material.dart';
import 'button_with_text.dart';

// Box, die die Texteingabe regelt...
class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.secondary,

      content: SizedBox(
        width: 200,
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Add a new task",
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: 8,
              children: [
                ButtonWithText(text: 'Save', onPressed: onSave),
                ButtonWithText(text: 'Cancel', onPressed: onCancel)
              ],
            )
          ],
        )
      ),
    );
  }
}
