import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pomodo/database/database.dart';
import '../utils/dialog_box.dart';

/*
  Die `TodoList`-Klasse zeigt eine Liste von Aufgaben an, die in der
  `PomodoDatabase` gespeichert sind. Benutzer können Aufgaben abhaken,
  hinzufügen und löschen, und die Datenbank wird nach jeder Änderung
  aktualisiert.
 */

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: PomodoDatabase.toDoList.length,
            itemBuilder: (context, index){
              return TodoTile(
                taskName: PomodoDatabase.toDoList[index][0],
                taskComplete: PomodoDatabase.toDoList[index][1],
                onChanged: (value) => checkBoxChanged(value, index),
                onDelete: (context) => deleteTask(index),
              );
            }
        ),

        //button
        floatingActionButton:
        FloatingActionButton(
          onPressed: addToDo,
          child: Icon(Icons.add),

        )
    );
  }

  final TextEditingController _controller = TextEditingController();



  // ---------------------- Hilfsmethoden -------------------------
  // Feld abhaken
  void checkBoxChanged(bool? value, int index)
  {
    setState(() {
      PomodoDatabase.toDoList[index][1] = !PomodoDatabase.toDoList[index][1];
    });
    // Wenn es offene task war OpenToDos decrementen
    if(PomodoDatabase.toDoList[index][1])
    {
      PomodoDatabase.toDosDone++;
      PomodoDatabase.toDosOpen--;
    }
    else
    {
        PomodoDatabase.toDosDone--;
        PomodoDatabase.toDosOpen++;
    }

    PomodoDatabase.updateData();
  }

  // Aufgabe hinzufügen
  void addToDo()
  {
    showDialog(
        context: context,
        builder: (context)
        {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: (){Navigator.of(context).pop();},);
        }
    );
  }

  // neue Aufgabe speichern
  void saveNewTask()
  {
    setState(() {
      if(_controller.text.isNotEmpty)
      {
        PomodoDatabase.toDoList.add([_controller.text, false]);
        _controller.clear();
      }
      Navigator.of(context).pop();
    });
    // OpenToDos increment
    PomodoDatabase.toDosOpen++;
    PomodoDatabase.updateData();
  }

  // task löschen
  void deleteTask(int index)
  {
    // Wenn es offene task war OpenToDos decrementen
    if(!PomodoDatabase.toDoList[index][1])
    {
      PomodoDatabase.toDosOpen--;
    }
    else
    {
      PomodoDatabase.toDosDone--;
    }

    setState(() {
      PomodoDatabase.toDoList.removeAt(index);
    });

    PomodoDatabase.updateData();
  }
}



//Hilfsklasse für die TodoFelder
class TodoTile extends StatelessWidget {
  final String taskName;
  final bool taskComplete;
  final Function(bool?) ? onChanged;
  final Function (BuildContext)? onDelete;

  const TodoTile({
    super.key,
    required this.taskName,
    required this.taskComplete,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                onPressed: onDelete,
                icon: Icons.delete,
                backgroundColor: Theme.of(context).colorScheme.error,
                borderRadius: BorderRadius.circular(10),
              )
            ]
        ),
        child: Container(
          padding: EdgeInsets.all(12),

          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(10)
          ),

          child: Row(
            children: [
              Checkbox(
                value: taskComplete,
                onChanged: onChanged,
                activeColor: Theme.of(context).colorScheme.onPrimary,
                checkColor: Theme.of(context).colorScheme.secondary,
              ),
              Flexible(
                child: Text(
                    taskName,
                    style: TextStyle(
                        decoration: taskComplete ? TextDecoration.lineThrough : TextDecoration.none,
                        fontSize: 15
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
