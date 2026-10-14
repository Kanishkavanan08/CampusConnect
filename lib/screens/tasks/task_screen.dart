import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/task_provider.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  // A helper function to show a dialog for adding a new task
  void _showAddTaskDialog(BuildContext context) {
    final TextEditingController taskController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Task'),
        content: TextField(
          controller: taskController,
          decoration: const InputDecoration(hintText: 'Enter task description'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Close dialog
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (taskController.text.isNotEmpty) {
                // Use context.read() because we are inside a button press!
                context.read<TaskProvider>().addTask(taskController.text);
                Navigator.pop(context); // Close dialog
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Use context.watch() because we need the UI to update when the list changes!
    final taskProvider = context.watch<TaskProvider>();
    final tasks = taskProvider.tasks;

    return Scaffold(
      // We don't need an AppBar here because the Dashboard already has one!
      body: tasks.isEmpty
          ? const Center(child: Text('No tasks yet. Tap + to add one!'))
          : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            leading: Checkbox(
              value: task.isCompleted,
              onChanged: (value) {
                context.read<TaskProvider>().toggleTaskStatus(task.id);
              },
            ),
            title: Text(
              task.title,
              style: TextStyle(
                // Add a strike-through if completed
                decoration: task.isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                context.read<TaskProvider>().deleteTask(task.id);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}