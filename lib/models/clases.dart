import 'package:flutter/src/material/time.dart';
import 'package:flutter/material.dart';

class Project {
  final String id;
  final String name;

  Project({required this.id, required this.name});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

class Task {
  final String id;
  final String name;
  final String projectId;

  Task({required this.id, required this.name, required this.projectId});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      name: json['name'],
      projectId: json['projectId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'projectId': projectId};
  }
}

class TimeEntry {
  final String id;
  final String projectId;

  final String taskId;
  final Duration totalTime;
  final DateTime date;
  final String notes;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;

  TimeEntry({
    required this.id,
    required this.projectId,

    required this.taskId,
    required this.totalTime,
    required this.date,
    required this.notes,
    this.startTime,
    this.endTime,
  });

  factory TimeEntry.fromJson(Map<String, dynamic> json) {
    return TimeEntry(
      id: json['id'],
      projectId: json['projectId'],
      taskId: json['taskId'],

      totalTime: Duration(minutes: json['totalTime']),
      date: DateTime.parse(json['date']),
      notes: json['notes'],
      startTime:
          json['startTime'] != null
              ? TimeOfDay(
                hour: int.parse(json['startTime'].split(':')[0]),
                minute: int.parse(json['startTime'].split(':')[1]),
              )
              : null,
      endTime:
          json['endTime'] != null
              ? TimeOfDay(
                hour: int.parse(json['endTime'].split(':')[0]),
                minute: int.parse(json['endTime'].split(':')[1]),
              )
              : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'projectId': projectId,

      'taskId': taskId,
      'totalTime': totalTime.inMinutes,
      'date': date.toIso8601String(),
      'notes': notes,
      'startTime':
          startTime != null
              ? '${startTime!.hour}:${startTime!.minute.toString().padLeft(2, '0')}'
              : null,
      'endTime':
          endTime != null
              ? '${endTime!.hour}:${endTime!.minute.toString().padLeft(2, '0')}'
              : null,
    };
  }
}
