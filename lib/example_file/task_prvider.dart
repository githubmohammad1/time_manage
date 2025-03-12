// import 'package:flutter/material.dart';
// import '../models/clases.dart';

// class TaskProvider with ChangeNotifier {
//   List<Task> _tasks = [];

//   List<Task> get tasks => _tasks;

//   void addTask(Task task) {
//     _tasks.add(task);
//     notifyListeners();
//   }

//   void updateTask(Task updatedTask) {
//     final index = _tasks.indexWhere((task) => task.id == updatedTask.id);
//     if (index != -1) {
//       _tasks[index] = updatedTask;
//       notifyListeners();
//     }
//   }

//   void deleteTask(String id) {
//     _tasks.removeWhere((task) => task.id == id);
//     notifyListeners();
//   }
// }
