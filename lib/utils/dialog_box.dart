import 'package:flutter/material.dart';
import 'package:todo_list/utils/button.dart';

class DialogBox extends StatelessWidget {
  final VoidCallback onSave;
  final VoidCallback onCancel;
  // text controller
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  Map<String, dynamic>? todo;

  DialogBox({
    Key? key,
    required this.titleController,
    required this.descriptionController,
    required this.onSave,
    required this.onCancel,
    this.todo,
  }) : super(key: key) {
    titleController.text = todo?['title'] ?? '';
    descriptionController.text = todo?['description'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Title",
                ),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Description",
                ),
              ),

              // buttons -> save + cancel
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // save button
                  MyButton(
                    text: "Save",
                    onPressed: onSave,
                  ),

                  const SizedBox(width: 8),

                  // cancel button
                  MyButton(
                    text: "Cancel",
                    onPressed: onCancel,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
