import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_list/utils/dialog_box.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool) onChangedStatus;
  Function(bool) onUpdated;
  Function(BuildContext)? deleteFunction;

  ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChangedStatus,
    required this.onUpdated,
    required this.deleteFunction,
  });

  void handleCheckboxChanged(bool? isChecked) {
    if (isChecked != null) {
      onChangedStatus(isChecked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 202, 202, 200),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // checkbox
              Checkbox(
                value: taskCompleted,
                onChanged: handleCheckboxChanged,
                activeColor: Colors.black,
              ),

              // task name
              GestureDetector(
                onTap: () {
                  if (onUpdated != null) {
                    onUpdated(true);
                  }
                },
                child: Text(
                  taskName,
                  style: TextStyle(
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
