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

  TimeEntry({
    required this.id,
    required this.projectId,
    required this.taskId,
    required this.totalTime,
    required this.date,
    required this.notes,
  });

  factory TimeEntry.fromJson(Map<String, dynamic> json) {
    return TimeEntry(
      id: json['id'],
      projectId: json['projectId'],
      taskId: json['taskId'],
      totalTime: Duration(minutes: json['totalTime']), // مثال على التحويل
      date: DateTime.parse(json['date']),
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'projectId': projectId,
      'taskId': taskId,
      'totalTime': totalTime.inMinutes, // مثال على التحويل
      'date': date.toIso8601String(),
      'notes': notes,
    };
  }
}
