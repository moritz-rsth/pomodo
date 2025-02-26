import 'package:flutter/material.dart';

/*
  Modulare AppBar mit Icon, Titel etc. die in jedem Screen verwendet wird.
*/

class ScreenAppBar extends AppBar {
  final IconData icon;
  final String titleText;
  final BuildContext context;
  final bool zurueckPfeilErlaubt;

  ScreenAppBar({
    required this.icon,
    required this.titleText,
    required this.context,
    required this.zurueckPfeilErlaubt,
    super.key,
  }) : super(
    automaticallyImplyLeading: zurueckPfeilErlaubt,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 30),
        SizedBox(width: 16),
        Text(titleText, style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 20, fontWeight: FontWeight.bold
        )),
      ],
    ),
    backgroundColor: Theme.of(context).colorScheme.surface
  );
}