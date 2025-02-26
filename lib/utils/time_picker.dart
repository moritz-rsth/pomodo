import 'package:flutter/material.dart';
import '../database/database.dart';

/*
  Die TimerPicker-Klasse ermöglicht es dem Nutzer, die Dauer eines
  Pomodoro-Timers für Arbeits- oder Pausenphasen auszuwählen. Ein Slider
  wird verwendet, um die Zeit zwischen 1 und 60 Minuten einzustellen, wobei
  die entsprechende Zeit in der Datenbank aktualisiert wird, wenn der Slider
  bewegt wird. Die angezeigte Zeit wird je nach der workOrPause-Eigenschaft
  entweder als Arbeitszeit (“Work”) oder als Pausenzeit (“Pause” ) angezeigt,
  wobei standardmäßig 25 Minuten für Arbeit und 5 Minuten für Pause gesetzt
  sind.
 */

class TimerPicker extends StatefulWidget {
  final bool workOrPause; // true = Work, false = Pause

  const TimerPicker({
    super.key,
    required this.workOrPause,
  });

  @override
  State<TimerPicker> createState() => _TimerPickerState();
}

class _TimerPickerState extends State<TimerPicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          value: selectedTime().toDouble(),
          min: 1, // Minimale Zeit (1 Minute)
          max: 60, // Maximale Zeit (60 Minuten)
          divisions: 59, // Schritte zwischen 1 und 60
          label: '${selectedTime()} Minuten', // Angezeigte Zeit
          onChanged: (double value) {
            setState(() {
              updateSelectedTime(value.toInt()); // Aktualisiere die ausgewählte Zeit
            });
          },
        ),
        Text(
          '${widget.workOrPause ? 'Work' : 'Pause'} Time: ${selectedTime()} Minuten', // Zeige die ausgewählte Zeit an
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        Text(
          widget.workOrPause ? '(pomodoro: 25min)' : '(pomodoro: 5min)', // Zeige die ausgewählte Zeit an
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  // ---------------------- Hilfsmethoden -------------------------
  // Gibt momentan ausgewählte Zeit zurück, je nach Kontext
  int selectedTime()
  {
    if(widget.workOrPause)
    {
      return PomodoDatabase.pomodoroWorkMinutes;
    }
    else
    {
      return PomodoDatabase.pomodoroPauseMinutes;
    }
  }

  // Setzt ausgewählte Zeit in der Datenbank je nach Kontext auf neuen Wert
  void updateSelectedTime(int time)
  {
    if(widget.workOrPause)
    {
      PomodoDatabase.pomodoroWorkMinutes = time;
    }
    else
    {
      PomodoDatabase.pomodoroPauseMinutes = time;
    }
    PomodoDatabase.updateData();
  }
}