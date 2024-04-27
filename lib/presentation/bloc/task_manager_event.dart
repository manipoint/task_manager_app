part of 'task_manager_bloc.dart';


/// [TaskManagerEvent] is an abstract class that represents an event in a
/// [TaskManagerBloc].
///
/// This class is used to represent a state change in a [TaskManagerBloc].
/// Each concrete implementation of [TaskManagerEvent] represents a
/// specific action, such as creating a new task, fetching tasks, or deleting
/// a task.
///
/// The properties of a [TaskManagerEvent] are defined by its subclasses.
/// An abstract class cannot have properties, thus [TaskManagerEvent] does
/// not have any properties.
///
/// A [TaskManagerEvent] must override the [props] getter, which returns a
/// list of the object's properties as an [Iterable]. This list of properties
/// is used to determine if two [TaskManagerEvent] objects are equal.
///
/// In the case of [TaskManagerEvent], the [props] getter is overridden to
/// return an empty list, since [TaskManagerEvent] does not have any
/// properties.
abstract class TaskManagerEvent extends Equatable {
  const TaskManagerEvent();

  @override
  List<Object> get props => [];
}

/// [CreateTaskEvent] is a concrete implementation of [TaskManagerEvent].
///
/// This class represents a state change in a [TaskManagerBloc].
/// It represents the event of creating a new task.
///
/// The properties of a [CreateTaskEvent] are defined by its [task] property.
/// The [task] property represents the [TaskModel] object to be created.
///
/// The [CreateTaskEvent] must override the [props] getter, which returns a
/// list of the object's properties as an [Iterable]. This list of properties
/// is used to determine if two [CreateTaskEvent] objects are equal.
/// In the case of [CreateTaskEvent], the [props] getter returns a list
/// containing only the [task] property.
class CreateTaskEvent extends TaskManagerEvent{
  /// The [TaskModel] object to be created.
  final TaskModel task;
  
  /// Creates a new instance of [CreateTaskEvent].
  ///
  /// The [task] parameter represents the [TaskModel] object to be created.
  const CreateTaskEvent({required this.task});
  
  /// Returns a list containing only the [task] property.
  ///
  /// This list is used to determine if two [CreateTaskEvent] objects are equal.
  @override
  List<Object> get props => [task];
  
}


/// [FetchTasksEvent] is a concrete implementation of [TaskManagerEvent].
///
/// This class represents a state change in a [TaskManagerBloc].
/// It represents the event of fetching all tasks.
///
/// The [FetchTasksEvent] class does not have any properties.
///
/// The [FetchTasksEvent] must override the [props] getter, which returns an empty list.
/// This list is used to determine if two [FetchTasksEvent] objects are equal.
/// In this case, since the class does not have any properties, the list is empty.
///
/// The [FetchTasksEvent] class represents the event of fetching all tasks.
/// It is used by the [TaskManagerBloc] to fetch all tasks from the repository.
class FetchTasksEvent extends TaskManagerEvent{
  /// Returns an empty list, since the class does not have any properties.
  ///
  /// This list is used to determine if two [FetchTasksEvent] objects are equal.
  /// Since the class does not have any properties, the list is empty.
  @override
  List<Object> get props => [];
  
}


/// [DeleteTaskEvent] is a concrete implementation of [TaskManagerEvent].
///
/// This class represents a state change in a [TaskManagerBloc].
/// It represents the event of deleting a task.
///
/// The properties of a [DeleteTaskEvent] are defined by its [id] property.
/// The [id] property represents the id of the task to be deleted.
///
/// The [DeleteTaskEvent] must override the [props] getter, which returns a
/// list of the object's properties as an [Iterable]. This list of properties
/// is used to determine if two [DeleteTaskEvent] objects are equal.
/// In the case of [DeleteTaskEvent], the [props] getter returns a list
/// containing only the [id] property.
class DeleteTaskEvent extends TaskManagerEvent{
  /// The id of the task to be deleted.
  final String id;
  
  /// Creates a new instance of [DeleteTaskEvent].
  ///
  /// The [id] parameter represents the id of the task to be deleted.
  const DeleteTaskEvent({required this.id});
  
  /// Returns a list containing only the [id] property.
  ///
  /// This list is used to determine if two [DeleteTaskEvent] objects are equal.
  @override
  List<Object> get props => [id];
  
}
