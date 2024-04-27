import 'package:dartz/dartz.dart';

import '../repository/task_manager_repository.dart';
import 'task_manager_usecase.dart';


/// [DeleteTaskUseCase] is a concrete implementation of [TaskManagerUseCase]
/// that provides the concrete implementation of deleting a task in the
/// task manager repository.
///
/// This class is responsible for deleting a task in the task manager
/// repository. It takes a [String] representing the id of the task to be
/// deleted and returns a [Future] that resolves to an [Either] containing
/// either an [Exception] in case of an error or [Unit] in case of success.
///
/// Parameters:
/// - [repository]: A [TaskManagerRepository] object. The task manager
/// repository is responsible for creating, deleting, and fetching tasks.
///
/// See also:
/// - [TaskManagerUseCase]
/// - [TaskManagerRepository]
class DeleteTaskUseCase extends TaskManagerUseCase<Unit, String> {
  final TaskManagerRepository repository;

  /// Creates an instance of [DeleteTaskUseCase].
  ///
  /// The constructor takes a required [repository] parameter.
  /// The [repository] parameter is an instance of [TaskManagerRepository].
  /// It is responsible for creating, deleting, and fetching tasks.
  DeleteTaskUseCase({required this.repository});

  /// Executes the use case by calling the [repository.deleteTask] method.
  ///
  /// The method takes a [String] parameter [params].
  /// It represents the id of the task to be deleted.
  ///
  /// Returns a [Future] that resolves to an [Either] object.
  /// The [Either] object can contain an [Exception] in case of an error or [Unit] in case of success.
  @override
  Future<Either<Exception, Unit>> call(String params) async {
    final result = await repository.deleteTask(params);
    return result;
  }
}
