import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/models/clases.dart';

import 'package:time_tracker/provider/time_entire_provider.dart';

import 'package:uuid/uuid.dart';

class ManageTasksScreen extends StatefulWidget {
  const ManageTasksScreen({super.key});

  @override
  _ManageTasksScreenState createState() => _ManageTasksScreenState();
}

class _ManageTasksScreenState extends State<ManageTasksScreen> {
  void _addTask(BuildContext context) {
    String taskName = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ), // تعديل شكل الحواف
          title: const Text('Add Task'),
          content: TextField(
            onChanged: (value) => taskName = value,
            decoration: const InputDecoration(labelText: 'Task Name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (taskName.isNotEmpty) {
                  final uuid = const Uuid();
                  Provider.of<TimeEntryProvider>(
                    context,
                    listen: false,
                  ).addTask(
                    Task(
                      id: uuid.v4(),
                      name: taskName,
                      projectId: 'default_project', // يمكنك تعديل هذا
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Tasks'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<TimeEntryProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.tasks.length,
            itemBuilder: (context, index) {
              final task = provider.tasks[index];
              return ListTile(
                title: Text(task.name),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    provider.deleteTask(task.id);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTask(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
