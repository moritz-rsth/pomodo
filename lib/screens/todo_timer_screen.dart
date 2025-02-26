import 'package:flutter/material.dart';
import 'package:pomodo/widgets/todo_list.dart';
import 'package:pomodo/widgets/tomato_button.dart';
import '../utils/app_bar.dart';

/*
  ToDoScreen: Hat einen kleineren Pomodoro-Timer als der FocusScreen
  und zusätzlich eine erweiterbare ToDoListe.
 */

class TodoTimerScreen extends StatelessWidget {
  const TodoTimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: ScreenAppBar(
        icon: Icons.checklist_rounded,
        titleText: 'ToDo',
        context: context,
        zurueckPfeilErlaubt: true,
      ),
      body: Center(
        child: Column(
          children: [
            TomatoButton(buttonSize: 250),
            Expanded(child: TodoList())
          ],
        ),
      ),

    );
  }
}