// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:task_manager_app/domain/usecases/task_manager_usecase.dart';

import '../../data/models/task_model.dart';
import '../repository/task_manager_repository.dart';

/// The [CreateTaskUseCase] class is a concrete implementation of [TaskManagerUseCase]
/// that provides the concrete implementation of creating a new task in the
/// task manager repository.
///
/// This class is responsible for creating a new task in the task manager
/// repository. It takes a [TaskModel] object as an argument and returns a
/// [Future] that resolves to an [Either] object. The [Either] object can
/// contain an [Exception] in case of an error or [Unit] in case of success.
///
/// Parameters:
/// - [repository]: A [TaskManagerRepository] object. The task manager
/// repository is responsible for creating, deleting, and fetching tasks.
///
/// See also:
/// - [TaskManagerUseCase]
/// - [TaskManagerRepository]
/// - [TaskModel]
class CreateTaskUseCase extends TaskManagerUseCase<Unit, TaskModel> {
  final TaskManagerRepository repository;
  /// Constructs a [CreateTaskUseCase] object.
  ///
  /// Takes a [repository] object as an argument.
  ///
  /// Parameters:
  /// - [repository]: A [TaskManagerRepository] object. The task manager
  /// repository is responsible for creating, deleting, and fetching tasks.
  CreateTaskUseCase({
    required this.repository,
  });
  /// Creates a new task in the task manager repository.
  ///
  /// Takes a [TaskModel] object as an argument and returns a [Future] that
  /// resolves to an [Either] object. The [Either] object can contain an
  /// [Exception] in case of an error or [Unit] in case of success.
  ///
  /// Parameters:
  /// - [params]: A [TaskModel] object representing the task to be created.
  @override
  Future<Either<Exception, Unit>> call(TaskModel params) async {
    final result = repository.createTask(params);
    return result;
  }
}
