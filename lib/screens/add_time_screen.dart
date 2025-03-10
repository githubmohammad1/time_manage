import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/models/time_entry.dart';
import 'package:time_tracker/provider/time_entry_provider.dart';

class AddTimeEntryScreen extends StatefulWidget {
  const AddTimeEntryScreen({super.key});

  @override
  _AddTimeEntryScreenState createState() => _AddTimeEntryScreenState();
}

class _AddTimeEntryScreenState extends State<AddTimeEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  String projectId = '';
  String taskId = '';
  Duration totalTime = Duration.zero; // استخدام Duration
  DateTime date = DateTime.now();
  String notes = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Time Entry')),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            // ... (بقية الحقول)
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Total Time (minutes)',
              ), // تغيير التسمية
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  totalTime = Duration(minutes: int.tryParse(value) ?? 0);
                });
              },
            ),
            // ... (بقية الحقول)
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Provider.of<TimeEntryProvider>(
                    context,
                    listen: false,
                  ).addTimeEntry(
                    TimeEntry(
                      id: DateTime.now().toString(), // يجب تغييرها
                      projectId: projectId,
                      taskId: taskId,
                      totalTime: totalTime,
                      date: date,
                      notes: notes,
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
