import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/provider/time_entire_provider.dart';

import 'add_time_screen.dart';

import 'project_manage_screen.dart';
import 'task_mange.dart';
import 'time_entry_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(
          backgroundColor: const Color(0xFFE0F2F7), // تغيير لون الخلفية
          child: ListView(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xFF80CBC4), // لون رأس الدرج
                ),
                child: const Text(
                  'Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.business), // أيقونة المشاريع
                title: const Text('Projects'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ManageProjectsScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.task), // أيقونة المهام
                title: const Text('Tasks'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ManageTasksScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Center(child: const Text('Time Tracking')),
          // leading: IconButton(
          //   icon: const Icon(Icons.menu),
          //   onPressed: () {
          //     Scaffold.of(context).openDrawer();
          //   },
          // ),
          bottom: const TabBar(
            tabs: [Tab(text: 'All Entries'), Tab(text: 'Grouped by Projects')],
          ),
        ),
        body: TabBarView(
          children: [
            Consumer<TimeEntryProvider>(
              builder: (context, provider, child) {
                if (provider.entries.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.access_time, size: 80, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'No time entries yet!',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 8),
                        Text('Tap the + button to add your first entry.'),
                      ],
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: provider.entries.length,
                    itemBuilder: (context, index) {
                      final entry = provider.entries[index];
                      return ListTile(
                        title: Text(
                          '${entry.projectId} - ${entry.totalTime.inHours} hours',
                        ),
                        subtitle: Text(
                          '${entry.date.toString()} - Notes: ${entry.notes}',
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      TimeEntryDetailsScreen(entry: entry),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
            const Center(child: Text('Grouped by Projects Content')),
          ],
        ),
        floatingActionButton: FloatingActionButton(
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
      ),
    );
  }
}
