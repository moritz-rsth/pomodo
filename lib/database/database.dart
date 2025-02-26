import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
/*
  Datenbank für die App: Es wird alles mit Hive verwaltet.
  Hive ist eine schnelle und leichtgewichtige NoSQL-Datenbank
  für Flutter und Dart. Da nur einfache Datentypen (Listen, Strings etc.)
  gespeichert werden könne, müssen die Farb-Einstellungen in Hexcode
  umgewandelt werden.
 */
class PomodoDatabase
{
  // ToDoListe mit default werten
  static List toDoList = [["swipen, um zu löschen", false]];
  // Daten für die Statistik: Anzahl Gesamtminuten und Durchläufen
  static int totalTime = 0;
  static int totalSessions = 0;
  static int toDosDone = 0;
  static int toDosOpen = 1;
  // Länge der Arbeits- und Pausenzeit
  static int pomodoroWorkMinutes = 25;
  static int pomodoroPauseMinutes = 5;
  // Alle Sounds aus den Assets, die im Pubspec angegeben sind
  static String femaleSoundWork = 'sounds/femaleSoundWork.mp3';
  static String femaleSoundPause = 'sounds/femaleSoundPause.mp3';
  static String maleSoundWork = 'sounds/maleSoundWork.mp3';
  static String maleSoundPause = 'sounds/maleSoundPause.mp3';
  static String timerSound = 'sounds/timerSound.mp3';
  // Verwendete Sounds
  static String workSound = maleSoundWork;
  static String pauseSound = maleSoundPause;
  // Farben in Hex mit default Werten
  static List lightColorsHex = [
    colorToHex(Colors.grey[800]!),
    colorToHex(Colors.greenAccent[200]!),
    colorToHex(Colors.green[800]!),
    colorToHex(Colors.black)
  ];
  static List darkColorsHex = [
    colorToHex(Colors.grey[400]!),
    colorToHex(Colors.red[400]!),
    colorToHex(Colors.blueGrey[800]!),
    colorToHex(Colors.grey[200]!)
  ];
  // Getter für Farben
  static get lightColorsCol => [
    hexToColor(lightColorsHex[0]),
    hexToColor(lightColorsHex[1]),
    hexToColor(lightColorsHex[2]),
    hexToColor(lightColorsHex[3])
  ];
  static get darkColorsCol => [
    hexToColor(darkColorsHex[0]),
    hexToColor(darkColorsHex[1]),
    hexToColor(darkColorsHex[2]),
    hexToColor(darkColorsHex[3])
  ];

  // Referenz zur Hive-Box
  static final _myBox = Hive.box('myBox');


  // Daten laden immer einmal bei neuem Öffnen in der Main abgerufen
  static void loadData()
  {
    // initiales Legen aller Werte in die Box
    if(_myBox.isEmpty) updateData();

    toDoList = _myBox.get('TODO_LIST');
    totalTime = _myBox.get('TOTAL_TIME');
    totalSessions = _myBox.get('TOTAL_SESSIONS');
    toDosDone = _myBox.get('TODOS_DONE');
    toDosOpen = _myBox.get('TODOS_OPEN');
    pomodoroPauseMinutes = _myBox.get('PAUSE_MINUTES');
    pomodoroWorkMinutes = _myBox.get('WORK_MINUTES');
    workSound = _myBox.get('WORK_SOUND');
    pauseSound = _myBox.get('PAUSE_SOUND');
    lightColorsHex = _myBox.get('LIGHT_COLORS');
    darkColorsHex = _myBox.get('DARK_COLORS');
  }

  // Datenbank updaten: Alle Variablen in Hive-Box abspeichern
  static void updateData()
  {
    _myBox.put('TODO_LIST', toDoList);
    _myBox.put('TOTAL_TIME', totalTime);
    _myBox.put('TOTAL_SESSIONS', totalSessions);
    _myBox.put('TODOS_DONE', toDosDone);
    _myBox.put('TODOS_OPEN', toDosOpen);
    _myBox.put('PAUSE_MINUTES', pomodoroPauseMinutes);
    _myBox.put('WORK_MINUTES', pomodoroWorkMinutes);
    _myBox.put('WORK_SOUND', workSound);
    _myBox.put('PAUSE_SOUND', pauseSound);
    _myBox.put('LIGHT_COLORS', lightColorsHex);
    _myBox.put('DARK_COLORS', darkColorsHex);
  }

  // ---------------------- Hilfsmethoden -------------------------
  // Konvertiere eine Color in einen Hex-String
  static String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0')}';

  }

  // Konvertiere einen Hex-String in eine Color
  static Color hexToColor(String hex) {
    return Color(int.parse(hex.substring(1), radix: 16));
  }
}