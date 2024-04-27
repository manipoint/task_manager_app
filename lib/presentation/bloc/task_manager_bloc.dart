import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/domain/usecases/task_manager_usecase.dart';

import '../../domain/usecases/create_task_usecase.dart';
import '../../domain/usecases/delete_task_usecase.dart';
import '../../domain/usecases/fetch_task_usecase.dart';

part 'task_manager_event.dart';
part 'task_manager_state.dart';

class TaskManagerBloc extends Bloc<TaskManagerEvent, TaskManagerState> {
  final CreateTaskUseCase createTaskUseCase;
  final FetchTaskUseCase fetchTasksUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;

  TaskManagerBloc({
    required this.createTaskUseCase,
    required this.fetchTasksUseCase,
    required this.deleteTaskUseCase,
  }) : super(const TaskManagerState()) {
    on<CreateTaskEvent>(_onCreateTask);
    on<FetchTasksEvent>(_onFetchTasks);
    on<DeleteTaskEvent>(_onDeleteTask);
  }

  Future<void> _onCreateTask(
      CreateTaskEvent event, Emitter<TaskManagerState> emit) async {
    emit(state.copyWith(status: TaskManagerStatus.loading));
    final result = await createTaskUseCase(event.task);
    result.fold(
      (exception) => emit(state.copyWith(
          status: TaskManagerStatus.error, exception: exception.toString())),
      (_) => add(FetchTasksEvent()),
    );
  }

  Future<void> _onFetchTasks(
      FetchTasksEvent event, Emitter<TaskManagerState> emit) async {
    emit(state.copyWith(status: TaskManagerStatus.loading));
    final result = await fetchTasksUseCase(const NoParameters());
    result.fold(
      (exception) {
        // Extracting just the message from the exception
        String errorMessage =
            exception.toString().replaceFirst('Exception: ', '');
        emit(state.copyWith(
            status: TaskManagerStatus.error, exception: errorMessage));
      },
      (tasks) =>
          emit(state.copyWith(status: TaskManagerStatus.loaded, tasks: tasks)),
    );
  }

  Future<void> _onDeleteTask(
      DeleteTaskEvent event, Emitter<TaskManagerState> emit) async {
    emit(state.copyWith(status: TaskManagerStatus.loading));
    final result = await deleteTaskUseCase(event.id);
    result.fold(
      (exception) => emit(state.copyWith(
          status: TaskManagerStatus.error, exception: exception.toString())),
      (_) => add(FetchTasksEvent()),
    );
  }
}
