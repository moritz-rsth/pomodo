import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:pomodo/database/database.dart';

/*
  Diese Klasse ermöglicht das Starten, Pausieren und Zurücksetzen des Pomodoro-Timers
  und wechselt automatisch zwischen Arbeits- und Pausenzeit, wobei sie die
  Gesamtarbeitszeit für die Datenbank erfasst. Durch die Implementierung von
  ChangeNotifier informiert sie die UI über Statusänderungen, sodass sich das
  Interface automatisch aktualisiert. Zusätzlich spielt sie akustische Signale
  ab, um den Nutzer über den Phasenwechsel zu informieren.
*/


class TimerProvider with ChangeNotifier {
  // Verbleibende Anzahl an Arbeits-/Pausenminuten
  int _remainingTimeWorking = PomodoDatabase.pomodoroWorkMinutes * 60;
  int _remainingTimePause = PomodoDatabase.pomodoroPauseMinutes * 60;
  // Ob der Timer läuft/pausiert ist
  bool _isRunning = false;
  bool _isPaused = false;
  // Ob die Arbeitsphase Aktiv ist
  bool _isWorkingPhase = true;
  // Gesamtanzahl an gearbeiteten Sekunden für die Datenbank
  static int _totalWorkedSecondsForDatabase = 0;
  // Audioplayer für den Sound
  final AudioPlayer audioPlayer = AudioPlayer();


  // Getter für den State
  int get remainingTimeWorking => _remainingTimeWorking;
  int get remainingTimePause => _remainingTimePause;
  bool get isRunning => _isRunning;
  bool get isPaused => _isPaused;
  bool get isWorkingPhase => _isWorkingPhase;


  // ---------------------- Hilfsmethoden -------------------------
  // Startet den Timer (wenn noch nicht gestartet)
  void startTimer() {
    if (!_isRunning) {
      _isRunning = true;
      _isPaused = false;
      _updateTimer();
    }
    notifyListeners();
  }

  // Pausiert den Timer
  void pauseTimer() {
    if (_isPaused) {
      _isPaused = false; // Timer fortsetzen
      _updateTimer(); // Timer aktualisieren
    } else {
      _isPaused = true; // Timer pausieren
    }
    notifyListeners();
  }

  // Setzt den Timer zurück
  void resetTimer() {
    _isRunning = false;
    _isPaused = false;
    _isWorkingPhase = true;
    _remainingTimeWorking = PomodoDatabase.pomodoroWorkMinutes * 60;
    _remainingTimePause = PomodoDatabase.pomodoroPauseMinutes * 60;
    notifyListeners();
  }

  // Updated den Timer
  void _updateTimer() {
    if (_isRunning && !_isPaused) {
      // Arbeitsphase
      if (_isWorkingPhase)
      {
        if (_remainingTimeWorking > 0)
        {
          _remainingTimeWorking--;
          _updateTotalWorkedSecondsForDatabase();
        }
        else
        {
          // Arbeitsphase abgelaufen, Pause starten
          _isWorkingPhase = false;
          // Eine Arbeitsphase in der Gesamtstatistik hinzufügen
          PomodoDatabase.totalSessions++;
          // Pausensound und Pausenzeit Setzen
          playSoundPauseStarts();
          _remainingTimePause = PomodoDatabase.pomodoroPauseMinutes * 60;

        }
      }
      // Pausenphase
      else {
        if (_remainingTimePause > 0)
        {
          _remainingTimePause--;
          _updateTotalWorkedSecondsForDatabase();
        }
        else
        {
          // Pause abgelaufen, Arbeitsphase starten
          _isWorkingPhase = true;
          playSoundWorkStarts();
          _remainingTimeWorking = PomodoDatabase.pomodoroWorkMinutes * 60;
        }
      }

      // Nach einer Sekunde wieder updaten
      if (_isRunning && !_isPaused)
      {
        Future.delayed(Duration(seconds: 1), () {
          _updateTimer();
        });
      }
    }
    notifyListeners();
  }

  // Erhöht die Gesamtanzahl an insgesamt gearbeiteter
  // Zeit im 60 Sekunden Abstand
  void _updateTotalWorkedSecondsForDatabase()
  {
    _totalWorkedSecondsForDatabase++;
    if(_totalWorkedSecondsForDatabase >= 60)
    {
        _totalWorkedSecondsForDatabase -= 60;
        PomodoDatabase.totalTime++;
    }
  }

  // Arbeitssound der Datenbank abspielen
  void playSoundWorkStarts() async
  {
    await audioPlayer.play(AssetSource(PomodoDatabase.workSound));
  }
  // Pausensound der Datenbank abspielen
  void playSoundPauseStarts() async
  {
    await audioPlayer.play(AssetSource(PomodoDatabase.pauseSound));
  }
}