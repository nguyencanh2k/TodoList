import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/utils/dialog_box.dart';
import 'package:todo_list/utils/todo_tile.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  // reference the hive box
  final _myBox = Hive.box('mybox');

  // text controller
  final _title = TextEditingController();
  final _description = TextEditingController();

  // create list textfield
  List<Map<String, dynamic>> textFields = [];

  @override
  void initState() {
    super.initState();

    textFields = [
      {
        'controller': _title,
        'controllerName': 'title',
        'hintText': 'Title',
      },
      {
        'controller': _description,
        'controllerName': 'description',
        'hintText': 'Description',
      },
    ];
  }

  // checkbox was tapped
  void checkBoxChanged(bool? value, id) {
    setState(() {
      // db.toDoList[index][1] = !db.toDoList[index][1];
    });
    // db.updateDataBase();
  }

  //get list todo
  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection("todo").snapshots();
  // save new task
  void saveNewTask() {
    try {
      if (_title.text.isNotEmpty || _description.text.isNotEmpty) {
        FirebaseFirestore.instance.collection("todo").add({
          'title': _title.text,
          'description': _description.text,
          'isCompleted': false
        });
        setState(() {
          _title.clear();
          _description.clear();
        });
        Navigator.of(context).pop();
        print('create in successfully');
      }
    } catch (e) {
      print('Firebase error $e');
    }
  }

  // create a new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return Container(
            child: Column(children: [
          DialogBox(
            textFields: textFields,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          ),
        ]));
      },
    );
  }

  // update task
  void updateTask(String? id) {
    print('id $id');
    // FirebaseFirestore.instance.collection("todo").doc(id).update({
    //   'title': _title.text,
    //   'description': _description.text,
    //   // 'isCompleted': false
    // });
    // Navigator.of(context).pop();
  }

  void showDialogBox(bool isUpdate, String? id, Map<String, dynamic> data) {
    if (isUpdate) {
      showDialog(
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              children: [
                DialogBox(
                  textFields: textFields,
                  onSave: () {
                    updateTask(id);
                  },
                  initialData: data,
                  onCancel: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  // delete task
  void deleteTask(id) {
    FirebaseFirestore.instance
        .collection("todo")
        .doc(id)
        .delete()
        .then((value) {
      // Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text('TO DO'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> todo =
                  snapshot.data?.docs[index].data() as Map<String, dynamic>;
              String? id = snapshot.data?.docs[index].id;
              bool isCompleted = false;
              dynamic isCompletedValue = todo['isCompleted'];
              if (isCompletedValue is bool) {
                isCompleted = isCompletedValue;
              } else if (isCompletedValue is String) {
                isCompleted = isCompletedValue.toLowerCase() == 'true';
              }
              return ToDoTile(
                textFields: textFields,
                taskName: todo['title'] ?? "Error",
                taskCompleted: isCompleted,
                onChanged: (value) => checkBoxChanged(value, id),
                deleteFunction: (context) => deleteTask(id),
                onUpdated: (value) => showDialogBox(value, id, todo),
              );
            },
          );
        },
      ),
    );
  }
}
