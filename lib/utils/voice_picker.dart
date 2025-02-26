import 'package:flutter/material.dart';
import 'package:pomodo/database/database.dart';

/*
  Die VoicePicker-Klasse ermöglicht die Auswahl von verschiedenen Sounds für
  Arbeits- oder Pausenphasen, basierend auf der workOrPause-Eigenschaft.
  Es gibt drei auswählbare Sounds, die jeweils mit einem Icon dargestellt
  werden. Beim Tippen auf eines der Icons wird der entsprechende Sound in
  der Datenbank gespeichert und die UI wird aktualisiert, um den ausgewählten
  Sound visuell hervorzuheben.
 */

class VoicePicker extends StatefulWidget {
  final String name;
  final IconData icon1;
  final String sound1;
  final IconData icon2;
  final String sound2;
  final IconData icon3;
  final String sound3;
  final bool workOrPause;

  const VoicePicker({
    super.key,
    required this.name,
    required this.icon1,
    required this.sound1,
    required this.icon2,
    required this.sound2,
    required this.icon3,
    required this.sound3,
    required this.workOrPause,
  });

  @override
  State<VoicePicker> createState() => _VoicePickerState();
}

class _VoicePickerState extends State<VoicePicker> {
  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        Text(widget.name,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        Wrap(
          children: [
            _buildVoiceButton(widget.icon1, widget.sound1, context),
            _buildVoiceButton(widget.icon2, widget.sound2, context),
            _buildVoiceButton(widget.icon3, widget.sound3, context),
          ],
        ),
      ],
    );
  }

  // ---------------------- Hilfsmethoden -------------------------
  // Bau-Funktion für einen Voice Button
  Widget _buildVoiceButton(IconData icon, String sound, BuildContext context) {
    final String selectedSound = (widget.workOrPause ? PomodoDatabase.workSound : PomodoDatabase.pauseSound);
    final bool isSelected = sound == selectedSound;

    return GestureDetector(
      onTap: () => {
        setState(() {
          if(widget.workOrPause) {
            PomodoDatabase.workSound = sound;
          } else {
            PomodoDatabase.pauseSound = sound;
          }
          PomodoDatabase.updateData();
        }),
      },
      child: Container(
        width: 60,
        height: 50,
        margin: EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: Theme
              .of(context)
              .colorScheme
              .surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme
                .of(context)
                .colorScheme
                .onPrimary, // Farbe des Rands
            width: isSelected ? 3.5 : 2.0, // Breite des Rands
          ),
        ),
        child: Icon(icon, size: 30,),
      ),
    );
  }
}