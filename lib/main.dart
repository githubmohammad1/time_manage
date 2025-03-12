import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/provider/time_entire_provider.dart'; // تصحيح المسار
import 'package:time_tracker/screens/homescreen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TimeEntryProvider()),
        // ChangeNotifierProvider(create: (context) => ProjectProvider()),
        // Correct provider name
        // ... other providers ...
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TimeEntryProvider())],
      child: MaterialApp(
        title: 'Time Tracker', // تغيير العنوان
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
