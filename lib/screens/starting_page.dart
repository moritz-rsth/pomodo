import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pomodo/utils/page_indicator.dart';
import 'home_screen.dart';
import 'focus_timer_screen.dart';
import 'multiplayer_screen.dart';
import 'settings_screen.dart';
import 'todo_timer_screen.dart';

/*
  Dieser Code implementiert die Startseite (StartingPage) einer Flutter-App als
  StatefulWidget. Die Seite bietet eine Funktionalität zum Navigieren zwischen
  mehreren Screens mit einem PageView und einem Page Indicator. Es gibt auch
  Interaktionen wie das Wischen nach oben, um Einstellungen zu öffnen, sowie
  Wischgesten, um den Status der Page Indicator anzuzeigen oder auszublenden.
 */

class StartingPage extends StatefulWidget {
  const StartingPage({super.key});

  @override
  State<StartingPage> createState() => _StartingPageState();
}

class _StartingPageState extends State<StartingPage> {
  //Hilfs-Attribute
  //PageController zur Registrierung von Swipes
  final PageController _pageController = PageController();
  //Index der current Page, falls später noch benötigt
  int _currentPage = 0;
  //Benötigt um:
  bool _isSwiping = false;
  //Sichtbarkeit der Bullets-Animation
  double _pageIndicatorOpacity = 1.0;
  // Timer zum Ausblenden für den Indicator
  Timer? _hideIndicatorTimer;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Verschieden aktionen bei den swipes
      body: GestureDetector(
        // Nach oben wischen → Einstellungen öffnen
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity! < -50) {
            _openSettings();
          }
        },
        //Seitlich wischen → pageIndicator einblenden
        onHorizontalDragStart: (_) {
          setState(() {
            _isSwiping = true;
            _showPageIndicator();
          });
        },
        onHorizontalDragEnd: (_) {
          setState(() {
            _isSwiping = false;
            _showPageIndicator();
          });
        },
        // Tippen auf den Bildschirm → Info anzeigen
        onTap: () {
          _showInfoSnackBar(context);
        },
        // Haupt-Stack
        child: Stack(
          alignment: Alignment.bottomCenter,

          children: [
            // Zirkuläres PageView-Scrolling
            PageView.builder(
              controller: _pageController,
              itemCount: 4,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                  _showPageIndicator();
                });
              },
              itemBuilder: (context, index) {
                final pages = [
                  HomeScreen(
                    callbackTomatoButton: () => _onTabTapped(1),
                    callbackToDoButton: () => _onTabTapped(2),
                  ),
                  FocusTimerScreen(),
                  TodoTimerScreen(),
                  MultiplayerScreen()
                ];
                return pages[index % pages.length];
              },
            ),

            //Page Indicator
            PageIndicator(
                opacity: _pageIndicatorOpacity,
                duration: Duration(milliseconds: 500),
                pageController: _pageController,
                context: context
            ),

            // Einstellungsbutton (nur im Web sichtbar)
            if (kIsWeb)
              Positioned(
                left: 16, // Abstand vom linken Rand
                bottom: 16, // Abstand vom unteren Rand
                child: FloatingActionButton(
                  onPressed: _openSettings,
                  child: Icon(Icons.settings),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ---------------------- Hilfsmethoden -------------------------
  // Einblenden des PageIndicators
  void _showPageIndicator() {
    setState(() {
      _pageIndicatorOpacity = 1.0;
    });

    // Falls ein vorheriger Timer läuft, abbrechen
    _hideIndicatorTimer?.cancel();

    // Neuen Timer starten
    _startHideTimer();
  }

// Startet oder setzt den Verzögerung-Timer zurück
  void _startHideTimer() {
    // Falls ein vorheriger Timer läuft, abbrechen
    _hideIndicatorTimer?.cancel();

    // Neuer Timer startet das Ausblenden nach 2 Sekunden
    _hideIndicatorTimer = Timer(Duration(seconds: 1), () {
      if (!_isSwiping) {
        setState(() {
          _pageIndicatorOpacity = 0.0;
        });
      }
    });
  }

  //Öffnet die Einstellungen
  void _openSettings() {
    showModalBottomSheet(
      context: context,
      //wird ausgeblendet, wenn auf screen getapped wird
      isDismissible: true,
      //man kann auf dem Sheet swipen
      enableDrag: true,
      // Ermöglicht höheres Bottom Sheet
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      clipBehavior: Clip.antiAlias,
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.8, // 90% der Bildschirmhöhe nutzen
        child: SettingsScreen(),
      ),
    );
  }

  // Navigatorfunktion für die Screens
  void _onTabTapped(int index) {
    setState(() {
      _currentPage = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
  }

  void _showInfoSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Swipe to change pages'),
        duration: Duration(seconds: 1), // Anzeigedauer
        behavior: SnackBarBehavior.fixed, // Positioniert den SnackBar oben
      ),
    );
  }
}
