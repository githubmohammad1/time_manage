import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/provider/time_entry_provider.dart';
// import 'package:time_tracker/providers/time_entry_provider.dart';

class ProjectTimeReportScreen extends StatelessWidget {
  const ProjectTimeReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Time Spent by Project')),
      body: Consumer<TimeEntryProvider>(
        builder: (context, provider, child) {
          final projectTimes = provider.getTimeSpentByProject();
          return ListView.builder(
            itemCount: projectTimes.length,
            itemBuilder: (context, index) {
              final projectId = projectTimes.keys.elementAt(index);
              final duration = projectTimes[projectId]!;
              return ListTile(
                title: Text('Project ID: $projectId'),
                subtitle: Text(
                  'Time: ${duration.inHours} hours ${duration.inMinutes.remainder(60)} minutes',
                ),
              );
            },
          );
        },
      ),
    );
  }
}
