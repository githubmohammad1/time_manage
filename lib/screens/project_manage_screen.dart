import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/models/clases.dart';
// import 'package:time_tracker/example_file/project_provider.dart';
import 'package:time_tracker/provider/time_entire_provider.dart';

import 'package:uuid/uuid.dart';

class ManageProjectsScreen extends StatefulWidget {
  const ManageProjectsScreen({super.key});

  @override
  _ManageProjectsScreenState createState() => _ManageProjectsScreenState();
}

class _ManageProjectsScreenState extends State<ManageProjectsScreen> {
  void _addProject(BuildContext context) {
    String projectName = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: const Text('Add Project'),
          content: TextField(
            onChanged: (value) => projectName = value,
            decoration: const InputDecoration(labelText: 'Project Name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (projectName.isNotEmpty) {
                  final uuid = const Uuid();
                  Provider.of<TimeEntryProvider>(
                    context,
                    listen: false,
                  ).addProject(Project(id: uuid.v4(), name: projectName));
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
        title: const Text('Manage Projects'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<TimeEntryProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.projects.length,
            itemBuilder: (context, index) {
              final project = provider.projects[index];
              return ListTile(
                title: Text(project.name),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    provider.deleteProject(project.id);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addProject(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
