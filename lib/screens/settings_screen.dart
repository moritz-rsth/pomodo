import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomodo/database/database.dart';
import 'package:pomodo/providers/color_provider.dart';
import 'package:pomodo/utils/color_picker_tile.dart';
import 'package:pomodo/utils/time_picker.dart';
import 'package:pomodo/utils/voice_picker.dart';
import 'package:provider/provider.dart';
import '../utils/app_bar.dart';

/*
  Settings Screen mit Einstellungsmöglichkeiten für
  1. Farben
  2. Pomodoro-Klingelton
  3. Pomodoro-Zeiten
  Abwechselnd passende Picker aus der Util Klasse mit Trennlinien
*/

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar:
      ScreenAppBar(
        icon: CupertinoIcons.settings,
        titleText: 'Settings',
        context: context,
        zurueckPfeilErlaubt: false,
      ),
      body: Center(
        child: ListView(
          children: [
            VoicePicker(
              name: 'Sound - start working',
              workOrPause: true,
              icon1: Icons.male,
              sound1: PomodoDatabase.maleSoundWork,
              icon2: Icons.female,
              sound2: PomodoDatabase.femaleSoundWork,
              icon3: Icons.timer,
              sound3: PomodoDatabase.timerSound,
            ),
            Container(
              margin: const EdgeInsets.only(top: 16, bottom: 20, right: 16, left: 16),
              height: 2,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            VoicePicker(
              name: 'Sound - pause',
              workOrPause: false,
              icon1: Icons.male,
              sound1: PomodoDatabase.maleSoundPause,
              icon2: Icons.female,
              sound2: PomodoDatabase.femaleSoundPause,
              icon3: Icons.timer,
              sound3: PomodoDatabase.timerSound,
            ),
            Container(
              margin: const EdgeInsets.only(top: 16, bottom: 20, right: 16, left: 16),
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            ColorPicker(
                name: 'Background Light Mode',
                lightOrDark: true,
                changingColor: 2,
                color1: Colors.green[800]!,
                color2: Colors.lightBlue,
                color3: Colors.purple[600]!,
                color4: Colors.yellow[800]!,
                color5: Colors.white,
                onColorChanged: (color) {colorProvider.updateLightTheme(background: color);}
                ),
            Container(
              margin: const EdgeInsets.only(top: 16, bottom: 20, right: 16, left: 16),
              height: 2,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            ColorPicker(
                name: 'Primary Light Mode',
                lightOrDark: true,
                changingColor: 0,
                color1: Colors.grey[800]!,
                color2: Colors.grey[600]!,
                color3: Colors.grey[400]!,
                color4:Colors.greenAccent,
                color5: Colors.white,
                onColorChanged: (color) {colorProvider.updateLightTheme(primary: color);}
            ),
            Container(
              margin: const EdgeInsets.only(top: 16, bottom: 20, right: 16, left: 16),
              height: 2,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            ColorPicker(
                name: 'Secondary Light Mode',
                lightOrDark: true,
                changingColor: 1,
                color1: Colors.greenAccent[200]!,
                color2: Colors.lightBlue,
                color3: Colors.pink[200]!,
                color4: Colors.yellow[400]!,
                color5: Colors.orange[400]!,
                onColorChanged: (color) {colorProvider.updateLightTheme(secondary: color);}
            ),
            Container(
              margin: const EdgeInsets.only(top: 16, bottom: 20, right: 16, left: 16),
              height: 2,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            ColorPicker(
                name: 'Text Light Mode',
                lightOrDark: true,
                changingColor: 3,
                color1: Colors.black,
                color2: Colors.blueGrey[800]!,
                color3: Colors.purple[800]!,
                color4: Colors.blue[800]!,
                color5: Colors.white,
                onColorChanged: (color) {colorProvider.updateLightTheme(text: color);}
            ),
            Container(
              margin: const EdgeInsets.only(top: 16, bottom: 20, right: 16, left: 16),
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            ColorPicker(
                name: 'Background Dark Mode',
                lightOrDark: false,
                changingColor: 2,
                color1: Colors.blueGrey[800]!,
                color2: Colors.purple[800]!,
                color3: Colors.black,
                color4: Colors.grey[800]!,
                color5: Colors.orange[200]!,
                onColorChanged: (color) {colorProvider.updateDarkTheme(background: color);}
            ),
            Container(
              margin: const EdgeInsets.only(top: 16, bottom: 20, right: 16, left: 16),
              height: 2,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            ColorPicker(
                name: 'Primary Dark Mode',
                lightOrDark: false,
                changingColor: 0,
                color1: Colors.grey[400]!,
                color2: Colors.lightBlue,
                color3: Colors.redAccent,
                color4: Colors.yellow[800]!,
                color5: Colors.white,
                onColorChanged: (color) {colorProvider.updateDarkTheme(primary: color);}
            ),
            Container(
              margin: const EdgeInsets.only(top: 16, bottom: 20, right: 16, left: 16),
              height: 2,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            ColorPicker(
                name: 'Secondary Dark Mode',
                lightOrDark: false,
                changingColor: 1,
                color1: Colors.red[400]!,
                color2: Colors.green,
                color3: Colors.blueGrey,
                color4: Colors.yellow[800]!,
                color5: Colors.white,
                onColorChanged: (color) {colorProvider.updateDarkTheme(secondary: color);}
            ),
            Container(
              margin: const EdgeInsets.only(top: 16, bottom: 20, right: 16, left: 16),
              height: 2,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            ColorPicker(
                name: 'Text Dark Mode',
                lightOrDark: false,
                changingColor: 3,
                color1: Colors.black,
                color2: Colors.blueGrey[800]!,
                color3: Colors.purple[400]!,
                color4: Colors.blue[200]!,
                color5: Colors.white,
                onColorChanged: (color) {colorProvider.updateDarkTheme(text: color);}
            ),
            Container(
              margin: const EdgeInsets.only(top: 16, bottom: 20, right: 16, left: 16),
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            TimerPicker(workOrPause: true),
            Container(
              margin: const EdgeInsets.only(top: 16, bottom: 20, right: 16, left: 16),
              height: 2,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            TimerPicker(workOrPause: false),
          ],
        ),
      ),
    );
  }
}