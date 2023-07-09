import 'package:flutter/material.dart';
import 'package:todo_list/utils/button.dart';

class DialogBox extends StatelessWidget {
  final List<Map<String, dynamic>> textFields;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.textFields,
    required this.onSave,
    required this.onCancel,
  });
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
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: textFields.length,
                itemBuilder: (context, index) {
                  final controller =
                      textFields[index]['controller'] as TextEditingController;
                  final hintText = textFields[index]['hintText'] as String;

                  return Container(
                      margin: EdgeInsets.only(bottom: 8.0),
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: hintText,
                        ),
                      ));
                },
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
