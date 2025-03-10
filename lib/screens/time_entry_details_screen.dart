import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/models/time_entry.dart';
import 'package:time_tracker/provider/time_entry_provider.dart';

class TimeEntryDetailsScreen extends StatelessWidget {
  final TimeEntry entry;

  const TimeEntryDetailsScreen({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Time Entry Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Project: ${entry.projectId}',
              style: const TextStyle(fontSize: 18),
            ),
            Text('Task: ${entry.taskId}', style: const TextStyle(fontSize: 18)),
            Text(
              'Time: ${entry.totalTime.inHours} hours',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Date: ${entry.date.toString()}',
              style: const TextStyle(fontSize: 18),
            ),
            Text('Notes: ${entry.notes}', style: const TextStyle(fontSize: 18)),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    // حذف إدخال الوقت
                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: const Text('Delete Time Entry?'),
                            content: const Text(
                              'Are you sure you want to delete this time entry?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Provider.of<TimeEntryProvider>(
                                    context,
                                    listen: false,
                                  ).deleteTimeEntry(entry.id);
                                  Navigator.pop(context); // إغلاق مربع الحوار
                                  Navigator.pop(
                                    context,
                                  ); // العودة إلى الشاشة الرئيسية
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
