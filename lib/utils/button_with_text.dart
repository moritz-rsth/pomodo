import 'package:flutter/material.dart';

// Einfacher Text, wird nur in Dialogue Box verwendet
class ButtonWithText extends StatelessWidget {
  final String text;
  VoidCallback onPressed;

  ButtonWithText({
    super.key,
    required this.text,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: onPressed,
        color: Theme.of(context).colorScheme.primary  ,
        child: Text(text),
    );
  }
}
