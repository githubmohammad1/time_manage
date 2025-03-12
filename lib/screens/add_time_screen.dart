import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:time_tracker/example_file/project_provider.dart';
// import 'package:time_tracker/example_file/task_prvider.dart';
import '../models/clases.dart';
import '../provider/time_entire_provider.dart';

import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart'; // حزمة تنسيق التاريخ والوقت

class AddTimeEntryScreen extends StatefulWidget {
  const AddTimeEntryScreen({super.key});

  @override
  _AddTimeEntryScreenState createState() => _AddTimeEntryScreenState();
}

class _AddTimeEntryScreenState extends State<AddTimeEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  String _projectId = '';

  String _taskId = '';
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  int _totalTime = 0;
  String _notes = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
      });
    }
  }

  void _saveTimeEntry(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final uuid = const Uuid();
      Provider.of<TimeEntryProvider>(context, listen: false).addTimeEntry(
        TimeEntry(
          id: uuid.v4(),
          projectId: _projectId,

          taskId: _taskId,
          date: _date,
          startTime: TimeOfDay(hour: _time.hour, minute: _time.minute),
          endTime: TimeOfDay(
            hour: _time.hour + _totalTime,
            minute: _time.minute,
          ),
          totalTime: Duration(hours: _totalTime),
          notes: _notes,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Time Entry')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Project'),
                items:
                    Provider.of<TimeEntryProvider>(context).projects.map((
                      project,
                    ) {
                      return DropdownMenuItem<String>(
                        value: project.id,
                        child: Text(project.name),
                      );
                    }).toList(),
                onChanged: (value) => _projectId = value!,
                validator:
                    (value) => value == null ? 'Please select a project' : null,
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Task'),
                items:
                    Provider.of<TimeEntryProvider>(context).tasks.map((task) {
                      return DropdownMenuItem<String>(
                        value: task.id,
                        child: Text(task.name),
                      );
                    }).toList(),
                onChanged: (value) => _taskId = value!,
                validator:
                    (value) => value == null ? 'Please select a task' : null,
              ),
              ListTile(
                title: Text('Date: ${DateFormat.yMd().format(_date)}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
              ),
              ListTile(
                title: Text('Time: ${_time.format(context)}'),
                trailing: const Icon(Icons.access_time),
                onTap: () => _selectTime(context),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Total Time (in hours)',
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) => _totalTime = int.parse(value!),
                validator:
                    (value) =>
                        value!.isEmpty ? 'Please enter total time' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Note'),
                onSaved: (value) => _notes = value!,
              ),
              ElevatedButton(
                onPressed: () => _saveTimeEntry(context),
                child: const Text('Save Time Entry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
