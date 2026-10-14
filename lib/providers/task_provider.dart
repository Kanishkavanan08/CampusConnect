import 'package:flutter/material.dart';
import '../models/task_model.dart';

// 1. Extend ChangeNotifier to give this class the ability to notify the UI
class TaskProvider extends ChangeNotifier {

  // Private list of tasks
  final List<Task> _tasks = [];

  // Public getter so the UI can read the tasks, but cannot directly modify the list
  List<Task> get tasks => _tasks;

  // Add a new task
  void addTask(String title) {
    final newTask = Task(
      id: DateTime.now().toString(), // Generates a simple unique ID for now
      title: title,
    );
    _tasks.add(newTask);

    // 2. CRITICAL: Tell the UI to rebuild!
    notifyListeners();
  }

  // Toggle a task between complete/incomplete
  void toggleTaskStatus(String id) {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex != -1) {
      _tasks[taskIndex].isCompleted = !_tasks[taskIndex].isCompleted;

      // 3. CRITICAL: Tell the UI to rebuild!
      notifyListeners();
    }
  }

  // Delete a task
  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }
}