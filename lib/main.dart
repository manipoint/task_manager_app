import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'data/models/task_model.dart';
import 'presentation/bloc/task_manager_bloc.dart';
import 'presentation/pages/task_managar_home_page.dart';
import 'helper/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(TaskModelAdapter());
  setupLocator();

  runApp(
    BlocProvider<TaskManagerBloc>(
      create: (context) => locator<TaskManagerBloc>(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Task Manager',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const TaskManagerHomePage());
  }
}
