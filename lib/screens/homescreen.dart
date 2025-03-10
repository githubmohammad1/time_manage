import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/provider/time_entry_provider.dart';

import 'add_time_screen.dart'; // تصحيح اسم الملف

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Time Entries')),
      body: Consumer<TimeEntryProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.entries.length,
            itemBuilder: (context, index) {
              final entry = provider.entries[index];
              return ListTile(
                title: Text(
                  '${entry.projectId} - ${entry.totalTime.inHours} hours',
                ), // استخدام Duration
                subtitle: Text(
                  '${entry.date.toString()} - Notes: ${entry.notes}',
                ),
                onTap: () {
                  // إضافة وظيفة لعرض تفاصيل الإدخال أو تعديله
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTimeEntryScreen()),
          );
        },
        tooltip: 'Add Time Entry',
        child: const Icon(Icons.add),
      ),
    );
  }
}
