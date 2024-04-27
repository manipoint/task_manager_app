import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';


/// [TaskManagerUseCase] is an abstract class that represents a use case in the
/// context of the task manager app.
///
/// This class is a contract for a concrete implementation of a task manager
/// use case. Each use case represents a specific operation in the application,
/// such as creating a task, fetching tasks, or deleting a task.
///
/// The interface defines a single abstract method [call], which takes in a
/// parameter of type [P] and returns a [Future] that resolves to an [Either]
/// containing either an [Exception] in the case of an error or a value of
/// type [T] in the case of success.
///
/// [T] represents the type of the result of the use case.
///
/// [P] represents the type of the parameter that the use case takes.
///
/// The [call] method is responsible for executing the use case and returning
/// the result.
///
/// Classes that extend [TaskManagerUseCase] are expected to implement the
/// [call] method.
abstract class TaskManagerUseCase<T, P> {

  /// Executes the use case with the provided parameters.
  ///
  /// Takes in a parameter of type [P] and returns a [Future] that resolves to
  /// an [Either] containing either an [Exception] in the case of an error or
  /// a value of type [T] in the case of success.
  ///
  /// Parameters:
  /// - [params]: The parameters for the use case.
  ///
  /// Returns:
  /// - A [Future] that resolves to an [Either] containing either an
  ///   [Exception] in the case of an error or a value of type [T] in the case
  ///   of success.
  Future<Either<Exception, T>> call(P params);
}


/// [NoParameters] is a class that represents a parameter-less object for use
/// in [TaskManagerUseCase].
///
/// This class is used to indicate that a use case does not take any
/// parameters.
///
/// The [NoParameters] class is a subclass of [Equatable], which means it
/// overrides the [==] and [hashCode] operators to compare and hash instances
/// of this class.
///
/// The [props] getter returns an empty list, indicating that instances of
/// this class have no properties to compare or hash.
///
/// This class is used to simplify the implementation of concrete [TaskManagerUseCase]
/// subclasses that do not require any parameters.
class NoParameters extends Equatable {
  /// Constructs a new instance of [NoParameters].
  const NoParameters();

  /// Returns an empty list, indicating that instances of this class have no
  /// properties to compare or hash.
  ///
  /// Returns:
  /// - An empty list.
  @override
  List<Object> get props => [];
}

