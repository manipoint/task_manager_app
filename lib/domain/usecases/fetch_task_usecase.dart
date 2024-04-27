// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import '../../data/models/task_model.dart';
import '../repository/task_manager_repository.dart';
import 'task_manager_usecase.dart';

/// The [FetchTaskUseCase] class is a concrete implementation of [TaskManagerUseCase]
/// that provides the concrete implementation of fetching tasks in the
/// task manager repository.
///
/// This class is responsible for fetching tasks from the task manager
/// repository. It takes no parameters and returns a [Future] that resolves
/// to an [Either] object. The [Either] object can contain an [Exception] in
/// case of an error or a [List] of [TaskModel] in case of success.
///
/// Parameters:
/// - [repository]: A [TaskManagerRepository] object. The task manager
/// repository is responsible for creating, deleting, and fetching tasks.
///
/// See also:
/// - [TaskManagerUseCase]
/// - [TaskManagerRepository]
/// - [TaskModel]
class FetchTaskUseCase extends TaskManagerUseCase<List<TaskModel>, NoParameters> {
  final TaskManagerRepository repository;

  /// Creates an instance of [FetchTaskUseCase].
  ///
  /// Takes a single argument [repository] which is an instance of
  /// [TaskManagerRepository].
  FetchTaskUseCase({
    required this.repository,
  });

  /// Fetches tasks from the task manager repository.
  ///
  /// Takes an instance of [NoParameters] as a parameter. Returns a [Future]
  /// that resolves to an [Either] object. The [Either] object can contain
  /// an [Exception] in case of an error or a [List] of [TaskModel] in case of
  /// success.
  ///
  /// Returns:
  /// - A [Future] that resolves to an [Either] object.
  @override
  Future<Either<Exception, List<TaskModel>>> call(NoParameters params) async {
    final result = await repository.fetchTasks();
    return result;
  }
}

