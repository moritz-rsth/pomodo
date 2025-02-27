import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pomodo/database/database.dart';
import 'package:pomodo/providers/color_provider.dart';
import 'package:pomodo/providers/timer_provider.dart';
import 'package:pomodo/screens/starting_page.dart';
import 'package:provider/provider.dart';

void main() async {
  // Hive initialisieren
  await Hive.initFlutter();

  // Hive Box öffnen
  var box = await Hive.openBox('myBox');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TimerProvider(),),
        ChangeNotifierProvider(create: (_) => ColorProvider())
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({super.key}) {
    PomodoDatabase.loadData();
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // Hole den ColorProvider aus dem Widget-Baum
    final colorProvider = Provider.of<ColorProvider>(context);

    return MaterialApp(
      title: 'pomodo',
      debugShowCheckedModeBanner: false,
      // Light und Dark Theme der App definieren (aus App Colors)
      theme: ThemeData(
        colorScheme: colorProvider.lightColorScheme,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: colorProvider.darkColorScheme,
        useMaterial3: true,
      ),
      // Automatisierter Wechsel
      themeMode: ThemeMode.system,
      home: StartingPage(),
    );
  }
}