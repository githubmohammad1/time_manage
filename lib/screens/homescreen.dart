import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/provider/time_entry_provider.dart';
import 'package:time_tracker/screens/managment.dart';

import 'add_time_screen.dart'; // تصحيح اسم الملف
import 'project_time_report_screen.dart';
import 'time_entry_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // عدد علامات التبويب
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Manage Projects/Tasks'),
                onTap: () {
                  Navigator.pop(context); // إغلاق الدرج
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProjectTaskManagementScreen(),
                    ),
                  );
                },
              ),
              // ... عناصر قائمة أخرى ...
            ],
          ),
        ),

        appBar: AppBar(
          title: const Text('Time Entries'),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // إضافة وظيفة فتح الدرج هنا
            },
          ),
          bottom: const TabBar(
            tabs: [Tab(text: 'All Entries'), Tab(text: 'Grouped by Projects')],
          ),
        ),
        //
        body: Consumer<TimeEntryProvider>(
          builder: (context, provider, child) {
            return ListView.builder(
              itemCount: provider.entries.length,
              itemBuilder: (context, index) {
                final entry = provider.entries[index];
                return ListTile(
                  title: Text(
                    '${entry.projectId} - ${entry.totalTime.inHours} hours',
                  ),

                  // استخدام Duration
                  subtitle: Text(
                    '${entry.date.toString()} - Notes: ${entry.notes}',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => TimeEntryDetailsScreen(entry: entry),
                      ),
                    );
                    // إضافة وظيفة لعرض تفاصيل الإدخال أو تعديله
                  },
                );
              },
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
                    builder: (context) => const ProjectTimeReportScreen(),
                  ),
                );
              },
              tooltip: 'Project Time Report',
              child: const Icon(Icons.bar_chart),
            ),
            const SizedBox(height: 16),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddTimeEntryScreen(),
                  ),
                );
              },
              tooltip: 'Add Time Entry',
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
