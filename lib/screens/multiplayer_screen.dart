import 'package:flutter/material.dart';
import '../utils/app_bar.dart';

// Platzhalter Klasse für mögliche Multiplayer Erweiterung

class MultiplayerScreen extends StatelessWidget {
  const MultiplayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: ScreenAppBar(
        icon: Icons.people,
        titleText: 'Friends',
        context: context,
        zurueckPfeilErlaubt: true,
      ),
      body: Center(
        child: Text('Multiplayer Screen - Platzhalter'),
      ),
    );
  }
}