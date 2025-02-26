import 'package:flutter/material.dart';
import 'package:pomodo/database/database.dart';

/*
  Diese Klasse Regelt zentral das Farbschema der App. Dazu hat sie Methoden,
  um die Farben in der Datenbank zu aktualisieren und stellt auf basis der Farben
  aus der Datenbank ColorSchemes zur Verfügung, die in der Main im System
  initialisiert werden.
*/


class ColorProvider with ChangeNotifier {
  // Methode zum Aktualisieren der Light Theme Farben
  void updateLightTheme({Color? primary, Color? secondary, Color? background, Color? text,})
  {
    if (primary != null) PomodoDatabase.lightColorsHex[0] = colorToHex(primary);
    if (secondary != null) PomodoDatabase.lightColorsHex[1] = colorToHex(secondary);
    if (background != null) PomodoDatabase.lightColorsHex[2] = colorToHex(background);
    if (text != null) PomodoDatabase.lightColorsHex[3] = colorToHex(text);
    notifyListeners(); // Benachrichtigt alle Listener über die Änderung
  }

  // Methode zum Aktualisieren der Dark Theme Farben
  void updateDarkTheme({Color? primary, Color? secondary, Color? background, Color? text,})
  {
    if (primary != null) PomodoDatabase.darkColorsHex[0] = colorToHex(primary);
    if (secondary != null) PomodoDatabase.darkColorsHex[1] = colorToHex(secondary);
    if (background != null) PomodoDatabase.darkColorsHex[2] = colorToHex(background);
    if (text != null) PomodoDatabase.darkColorsHex[3] = colorToHex(text);
    notifyListeners(); // Benachrichtigt alle Listener über die Änderung
  }

  // Getter für ColorScheme Light
  ColorScheme get lightColorScheme => ColorScheme.light(
    brightness: Brightness.light,
    primary: hexToColor(PomodoDatabase.lightColorsHex[0]),
    secondary: hexToColor(PomodoDatabase.lightColorsHex[1]),
    surface: hexToColor(PomodoDatabase.lightColorsHex[2]),
    onPrimary: hexToColor(PomodoDatabase.lightColorsHex[3]),
    onSecondary: hexToColor(PomodoDatabase.lightColorsHex[3]),
    onSurface: hexToColor(PomodoDatabase.lightColorsHex[3]),
    error: Colors.red[400]!,
  );

  // Getter für ColorScheme Dark
  ColorScheme get darkColorScheme => ColorScheme.dark(
    brightness: Brightness.dark,
    primary: hexToColor(PomodoDatabase.darkColorsHex[0]),
    secondary: hexToColor(PomodoDatabase.darkColorsHex[1]),
    surface: hexToColor(PomodoDatabase.darkColorsHex[2]),
    onPrimary: hexToColor(PomodoDatabase.darkColorsHex[3]),
    onSecondary: hexToColor(PomodoDatabase.darkColorsHex[3]),
    onSurface: hexToColor(PomodoDatabase.darkColorsHex[3]),
    error: Colors.purple[300]!,
  );

  // ---------------------- Hilfsmethoden -------------------------
  // Konvertiere einen Hex-String in eine Color
  Color hexToColor(String hex) {
    return Color(int.parse(hex.substring(1), radix: 16));
  }
  // Konvertiere eine Color in einen Hex-String
  String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0')}';
  }
}