import 'package:dartz/dartz.dart';
import 'package:task_manager_app/data/models/task_model.dart';

import '../../data/source/task_manager_data_source.dart';
import 'task_manager_repository.dart';



  /// Implementation of [TaskManagerRepository] that provides the concrete implementation of
  /// task management operations.
  class TaskManagerRepositoryImplementation implements TaskManagerRepository {
    /// [dataSource] is the data source used to interact with the data layer.
    final TaskManagerDataSource dataSource;

    /// Constructs a [TaskManagerRepositoryImplementation] with the given [dataSource].
    TaskManagerRepositoryImplementation({required this.dataSource});

    @override
    /// Creates a new task in the task manager repository.
    ///
    /// Takes a [TaskModel] object as an argument and returns a [Future] that resolves to
    /// an [Either] object. The [Either] object can contain an [Exception] in case of an
    /// error or [Unit] in case of success.
    ///
    /// Parameters:
    /// - [task]: A [TaskModel] object representing the task to be created.
    ///
    /// Returns:
    /// - A [Future] that resolves to an [Either] object.
    Future<Either<Exception, Unit>> createTask(TaskModel task) async {
      return await dataSource.createTask(task);
    }

    @override
    /// Fetches all tasks from the task manager repository.
    ///
    /// Returns a [Future] that resolves to an [Either] object. The [Either] object can
    /// contain an [Exception] in case of an error or a [List] of [TaskModel] in case of success.
    ///
    /// Returns:
    /// - A [Future] that resolves to an [Either] object.
    Future<Either<Exception, List<TaskModel>>> fetchTasks() async {
      return await dataSource.fetchTasks();
    }

    @override
    /// Deletes a task with the given [id] from the task manager repository.
    ///
    /// Takes a [String] representing the id of the task to be deleted and returns a [Future]
    /// that resolves to an [Either] object. The [Either] object can contain an [Exception]
    /// in case of an error or [Unit] in case of success.
    ///
    /// Parameters:
    /// - [id]: A [String] representing the id of the task to be deleted.
    ///
    /// Returns:
    /// - A [Future] that resolves to an [Either] object.
    Future<Either<Exception, Unit>> deleteTask(String id) async {
      return await dataSource.deleteTask(id);
    }
  }
