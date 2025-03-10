import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/screens/AddProjectScreen.dart';
import 'package:time_tracker/screens/AddTaskScreen.dart';
import '../provider/time_entry_provider.dart';

class ProjectTaskManagementScreen extends StatelessWidget {
  const ProjectTaskManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Projects and Tasks')),
      body: Consumer<TimeEntryProvider>(
        builder: (context, provider, child) {
          return ListView(
            children: [
              const ListTile(title: Text('Projects')),
              ...provider.projects.map(
                (project) => ListTile(
                  title: Text(project.name),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // إضافة وظيفة التعديل هنا
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          provider.deleteProject(project.id);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const ListTile(title: Text('Tasks')),
              ...provider.tasks.map(
                (task) => ListTile(
                  title: Text(task.name),
                  subtitle: Text('Project ID: ${task.projectId}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // إضافة وظيفة التعديل هنا
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          provider.deleteTask(task.id);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddProjectScreen(),
                ),
              );
            },
            tooltip: 'Add Project',
            heroTag: 'addProject',
            child: const Icon(Icons.business),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddTaskScreen()),
              );
            },
            tooltip: 'Add Task',
            heroTag: 'addTask',
            child: const Icon(Icons.task),
          ),
        ],
      ),
    );
  }
}
