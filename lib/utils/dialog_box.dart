import 'package:flutter/material.dart';
import 'package:todo_list/utils/button.dart';

class DialogBox extends StatelessWidget {
  final List<Map<String, dynamic>> textFields;
  final Map<String, dynamic>? initialData;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  DialogBox({
    Key? key,
    required this.textFields,
    this.initialData = const {},
    required this.onSave,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sử dụng tham số initialData để khởi tạo giá trị cho các trường dữ liệu
    final controllers = textFields.map((field) {
      final controller = field['controller'] as TextEditingController;
      final controllerName = field['controllerName'] as String;
      final initialValue = initialData?[controllerName];
      return TextEditingController(text: initialValue?.toString() ?? '');
    }).toList();
    print('controllers $controllers');
    print('initialData $initialData');
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
                  final controller = controllers[index];
                  final hintText = textFields[index]['hintText'] as String;

                  return Container(
                    margin: EdgeInsets.only(bottom: 8.0),
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: hintText,
                      ),
                    ),
                  );
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
