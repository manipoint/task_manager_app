import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_manager_app/data/models/task_model.dart';

import 'task_manager_data_source.dart';


/// A concrete implementation of [TaskManagerDataSource].
///
/// This class provides the concrete implementation of task management operations.
/// It is responsible for creating, deleting, and fetching tasks using Hive for storage.
class TaskManagerDataSourceImplementation implements TaskManagerDataSource {
  /// The Hive box used to store tasks.
  Box<TaskModel>? _taskBox;

  /// Initializes the [TaskManagerDataSourceImplementation].
  ///
  /// This function is responsible for initializing the [_taskBox] using Hive.
  TaskManagerDataSourceImplementation() {
    _initialize();
  }

  /// Ensures that the [_taskBox] is initialized.
  ///
  /// If [_taskBox] is null, it initializes it using [_initialize].
  Future<void> _ensureInitialized() async {
    if (_taskBox == null) {
      await _initialize();
    }
  }

  /// Initializes the [_taskBox] using Hive.
  Future<void> _initialize() async {
    _taskBox = await Hive.openBox<TaskModel>('tasks');
  }

  @override
  Future<Either<Exception, Unit>> createTask(TaskModel task) async {
    /// Creates a new task using [_taskBox].
    ///
    /// The function returns a [Future] that resolves to an [Either] containing either an [Exception] in the case of an error or [Unit] in case of success.
    try {
      await _ensureInitialized();
      await _taskBox!.put(task.id, task);
      return const Right(unit);
    } catch (e) {
      return Left(Exception('Unable to create task: ${e.toString()}')); // using `Left` to indicate an error
    }
  }

  @override
  Future<Either<Exception, Unit>> deleteTask(String id) async {
    /// Deletes a task with the given [id] using [_taskBox].
    ///
    /// The function returns a [Future] that resolves to an [Either] containing either an [Exception] in the case of an error or [Unit] in case of success.
    try {
      await _ensureInitialized();
      await _taskBox!.delete(id);
      return const Right(unit);
    } catch (e) {
      return Left(Exception('Failed to delete task: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Exception, List<TaskModel>>> fetchTasks() async {
    /// Fetches all tasks using [_taskBox].
    ///
    /// The function returns a [Future] that resolves to an [Either] containing either an [Exception] in the case of an error or a [List] of [TaskModel] in case of success.
    try {
      await _ensureInitialized();
      final tasks = _taskBox!.values.toList();
      return Right(tasks);
    } catch (e) {
      return Left(Exception('Task fetch failed: ${e.toString()}'));
    }
  }
}
