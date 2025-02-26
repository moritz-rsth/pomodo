import 'package:flutter/material.dart';
import 'package:pomodo/utils/app_bar.dart';
import '../database/database.dart';

/*
  HomeScreen: Hier wird dem Nutzer eine Zusammenfassung seiner bisherigen
  Sitzungen gezeigt, einschließlich der gesamten Arbeitszeit, der
  abgeschlossenen Pomodoro-Sitzungen sowie erledigter und offener To-Dos.
  Die Klasse erhält über Callbacks Funktionen für zwei Schaltflächen: eine
  für den Start des Pomodoro-Timers (callbackTomatoButton) und eine für die
  To-Do-Verwaltung (callbackToDoButton).
*/

class HomeScreen extends StatelessWidget {
  //Callback Funktion innerhalb des Pageviews...
  final VoidCallback callbackTomatoButton;
  final VoidCallback callbackToDoButton;

  // Konstruktor nimmt Callback Funktionen
  const HomeScreen({
    super.key,
    required this.callbackTomatoButton,
    required this.callbackToDoButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: ScreenAppBar(
        icon: Icons.home_rounded,
        titleText: 'Home',
        context: context,
        zurueckPfeilErlaubt: true,
      ),


      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Total Time (am meisten hervorgehoben)
            Text(
              'Total Time',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '${PomodoDatabase.totalTime} min',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            SizedBox(height: 32),

            // Tomate mit Total Sessions in der Mitte (klickbar)
            GestureDetector(
              onTap: callbackTomatoButton,
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/images/Tomato/Tomato1024.png', // Neuer Pfad zum Bild
                      width: 300, // Neue Größe der Tomate
                      height: 300,
                    ),
                    Positioned(
                      top: 115, // Angepasste Positionierung des Texts
                      child: Text(
                        '${PomodoDatabase.totalSessions}',
                        style: TextStyle(
                          fontSize: 70, // Größere Schrift
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary, // Farbe aus dem Theme
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Text(
                'Total Sessions completed',
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),

            // Spacer, um den restlichen Platz zu füllen
            Spacer(),

            // ToDos Done und Open (klickbar)
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0), // Abstand vom unteren Rand
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Done ToDos (klickbar)
                  GestureDetector(
                    onTap: callbackToDoButton,
                    child: Column(
                      children: [
                        Icon(Icons.check_circle, color: Theme.of(context).colorScheme.onPrimary, size: 32),
                        SizedBox(height: 8),
                        Text(
                          'Done',
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        Text(
                          '${PomodoDatabase.toDosDone}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Open ToDos (klickbar)
                  GestureDetector(
                    onTap: callbackToDoButton,
                    child: Column(
                      children: [
                        Icon(Icons.radio_button_unchecked, color: Theme.of(context).colorScheme.onPrimary, size: 32),
                        SizedBox(height: 8),
                        Text(
                          'Open',
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        Text(
                          '${PomodoDatabase.toDosOpen}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
