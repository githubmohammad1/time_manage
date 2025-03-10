import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/provider/time_entry_provider.dart';

class ProjectTaskManagementScreen extends StatelessWidget {
  const ProjectTaskManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Projects and Tasks')),
      body: Consumer<TimeEntryProvider>(
        builder: (context, provider, child) {
          // تنفيذ قوائم لإدارة المشاريع والمهام هنا
          return const Center(child: Text('Manage Projects and Tasks'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // إضافة مشروع أو مهمة جديدة
        },
        tooltip: 'Add Project/Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
