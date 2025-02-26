import 'package:flutter/material.dart';
import 'package:pomodo/utils/app_bar.dart';
import 'package:pomodo/widgets/tomato_button.dart';

/*
  Diese Klasse Enthält nur den Pomodoro Timer, der Focus-Sessions starten kann.
*/

class FocusTimerScreen extends StatelessWidget {
  const FocusTimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: ScreenAppBar(
          icon: Icons.filter_center_focus,
          titleText: 'Focus',
          context: context,
          zurueckPfeilErlaubt: true,
        ),
      body: Column(
        children: [
          Expanded( // Nimmt den gesamten verfügbaren Platz ein
            child: Center(
              child: TomatoButton(buttonSize: 400),
            ),
          ),
        ],
      ),
    );
  }
}