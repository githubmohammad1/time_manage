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
          backgroundColor: const Color(0xFFE0F2F7),
          child: ListView(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(color: Color(0xFF80CBC4)),
                child: const Text(
                  'Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.business),
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
                leading: const Icon(Icons.task),
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
          title: const Center(child: Text('Time Tracking')),
          bottom: const TabBar(
            tabs: [Tab(text: 'All Entries'), Tab(text: 'Grouped by Projects')],
          ),
        ),
        body: TabBarView(
          children: [
            // Tab 1: All Entries (unchanged)
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

            // Tab 2: Grouped by Projects (modified)
            Consumer<TimeEntryProvider>(
              builder: (context, provider, child) {
                final groupedEntries = provider.groupEntriesByProject();

                if (groupedEntries.isEmpty) {
                  return const Center(
                    child: Text('No time entries to display.'),
                  );
                }

                return ListView.builder(
                  itemCount: groupedEntries.length,
                  itemBuilder: (context, index) {
                    final projectName = groupedEntries.keys.elementAt(index);
                    final entries = groupedEntries[projectName]!;

                    return ExpansionTile(
                      title: Text(projectName),
                      children:
                          entries.map((entry) {
                            return ListTile(
                              title: Text('${entry.totalTime.inHours} hours'),
                              subtitle: Text(
                                '${entry.date.toString()} - Notes: ${entry.notes}',
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => TimeEntryDetailsScreen(
                                          entry: entry,
                                        ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                    );
                  },
                );
              },
            ),
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
