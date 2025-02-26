import 'package:flutter/material.dart';
import 'package:pomodo/database/database.dart';
import 'package:provider/provider.dart';
import '../providers/timer_provider.dart';

/*
  Die TomatoButton-Klasse ist ein stateless Widget, das die Benutzeroberfläche
  für einen Pomodoro-Timer darstellt. Es kombiniert visuelle Elemente wie ein
  Tomatenbild, Schaltflächen und einen Fortschrittsbalken, um den Timer zu
  steuern und den aktuellen Status anzuzeigen. Die Klasse interagiert mit
  einem TimerProvider (über den Provider-Mechanismus), um den Timer zu starten,
  zu pausieren und zurückzusetzen.
 */


class TomatoButton extends StatelessWidget {
  final double buttonSize;

  const TomatoButton({super.key, required this.buttonSize});

  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/Tomato/Tomato1024.png',
                  width: buttonSize,
                  height: buttonSize,
                ),
                Positioned(
                  top: buttonSize / 2.1, // Angepasste Positionierung des Texts
                  child: chooseIcon(timerProvider, context),
                ),
              ],
            ),
            Text(
              timerProvider.isRunning
                  ? (timerProvider.isPaused ? 'Pausiert' : 'Zeit zu arbeiten...')
                  : 'Starte Pomodoro',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        ),
        Opacity(
            opacity: (timerProvider.isRunning || timerProvider.isPaused) ? 1.0 : 0.0,
            child: Column(
              children: [
                SizedBox(height: 20),
                Container(
                  width: 200,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        width: 200 *
                            (timerProvider.isWorkingPhase
                                ? (timerProvider.remainingTimeWorking / (PomodoDatabase.pomodoroWorkMinutes * 60))
                                : (timerProvider.remainingTimePause / (PomodoDatabase.pomodoroPauseMinutes * 60))),
                        height: 5,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  timerProvider.isWorkingPhase
                      ? '${(timerProvider.remainingTimeWorking ~/ 60).toString().padLeft(2, '0')}:${(timerProvider.remainingTimeWorking % 60).toString().padLeft(2, '0')}'
                      : '${(timerProvider.remainingTimePause ~/ 60).toString().padLeft(2, '0')}:${(timerProvider.remainingTimePause % 60).toString().padLeft(2, '0')}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
        ),
      ],
    );
  }

  // Hilfsfunktionen
  // Richtiges Icon in Abhängigkeit vom time Provider einblenden
  Widget chooseIcon(TimerProvider timerProvider, BuildContext context)
  {
    if(timerProvider.isRunning)
    {
        return Row(
          children: [
            IconButton(
              onPressed: timerProvider.pauseTimer,
              padding: EdgeInsets.all(0),
              icon: Icon(
                Icons.pause,
                size: buttonSize / 5,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            SizedBox(width: buttonSize / 20),
            IconButton(
              onPressed: timerProvider.resetTimer,
              padding: EdgeInsets.all(0),
              icon: Icon(
                Icons.refresh,
                size: buttonSize / 5,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        );
    }
    else
    {
        return IconButton(
          onPressed: timerProvider.startTimer,
          icon: Icon(
            Icons.play_arrow,
            size: buttonSize / 5,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        );
    }
  }
}