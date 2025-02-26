import 'package:flutter/material.dart';
import 'package:pomodo/database/database.dart';

/*
  Die ColorPicker-Klasse ist ein StatefulWidget, das eine Auswahl an Farben
  bietet, aus denen der Nutzer eine auswählen kann. Sie zeigt einen Text mit
  dem Namen des Farbselectors und eine Reihe von Farbauswahl-Buttons, wobei
  jeder Button eine andere Farbe darstellt. Wenn eine Farbe ausgewählt wird,
  wird eine Rückmeldung durch den onColorChanged-Callback gegeben, und die
  Daten in der Datenbank werden aktualisiert. Die Auswahl der aktuellen Farbe
  wird durch einen dickeren Rand hervorgehoben. Die Farben werden je nach
  Einstellung entweder aus einer hellen oder dunklen Farbpalette geladen.
 */


class ColorPicker extends StatefulWidget {
  // Funktion zur Änderung bei Auswahl einer Farbe
  final ValueChanged<Color> onColorChanged;
  final String name;
  // Alle auswählbaren Farben
  final Color color1;
  final Color color2;
  final Color color3;
  final Color color4;
  final Color color5;
  // Infos für die zu ändernde Farbe aus der Datenbank
  final bool lightOrDark;
  final int changingColor;

  const ColorPicker({
    super.key,
    required this.onColorChanged,
    required this.name,
    required this.color1,
    required this.color2,
    required this.color3,
    required this.color4,
    required this.color5,
    required this.lightOrDark,
    required this.changingColor,
  });

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  // Reihe von 5 Buttons
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.name,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        Wrap(
          children: [
            _buildColorButton(widget.color1, context),
            _buildColorButton(widget.color2, context),
            _buildColorButton(widget.color3, context),
            _buildColorButton(widget.color4, context),
            _buildColorButton(widget.color5, context),
          ],
        ),
      ],
    );
  }

  // ---------------------- Hilfsmethoden -------------------------
  // Bau-Funktion für die Buttons
  Widget _buildColorButton(Color color, BuildContext context) {
    final bool isSelected =  selectedColor() == color; // Prüfe, ob die Farbe ausgewählt ist

    return GestureDetector(
      onTap: () {
        setState(() {
          widget.onColorChanged(color);
          PomodoDatabase.updateData();
        });
      },
      child: Container(
        width: 60,
        height: 50,
        margin: EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme.of(context).colorScheme.onPrimary,
            width: isSelected ? 4.0 : 2.0, // Dicker Rand, wenn ausgewählt
          ),
        ),
      ),
    );
  }

  // Gibt momentan Ausgewählte Farbe aus der Datenbank zurück
  Color selectedColor()
  {
    if(widget.lightOrDark)
    {
      return PomodoDatabase.lightColorsCol[widget.changingColor];
    }
    else
    {
      return PomodoDatabase.darkColorsCol[widget.changingColor];
    }
  }
}