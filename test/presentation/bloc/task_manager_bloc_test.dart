import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/source/task_manager_data_source.dart';
import 'package:task_manager_app/domain/repository/task_manager_repository.dart';
import 'package:task_manager_app/domain/usecases/create_task_usecase.dart';
import 'package:task_manager_app/domain/usecases/delete_task_usecase.dart';
import 'package:task_manager_app/domain/usecases/fetch_task_usecase.dart';
import 'package:task_manager_app/domain/usecases/task_manager_usecase.dart';
import 'package:task_manager_app/presentation/bloc/task_manager_bloc.dart';

class MockTaskManagerDataSource extends Mock implements TaskManagerDataSource {}

class MockTaskManagerRepository extends Mock implements TaskManagerRepository {}

class MockCreateTaskUseCase extends Mock implements CreateTaskUseCase {}

class MockFetchTaskUseCase extends Mock implements FetchTaskUseCase {}

class MockDeleteTaskUseCase extends Mock implements DeleteTaskUseCase {}

class FakeNoParameters extends Fake implements NoParameters {}

class FakeTaskModel extends Fake implements TaskModel {}

void main() {
  final getIt = GetIt.instance;

  setUpAll(() {
    registerFallbackValue(FakeNoParameters());
    registerFallbackValue(FakeTaskModel());
  });

  setUp(() {
    getIt.reset();
    getIt.registerLazySingleton<TaskManagerDataSource>(
        () => MockTaskManagerDataSource());
    getIt.registerLazySingleton<TaskManagerRepository>(
        () => MockTaskManagerRepository());
    getIt.registerLazySingleton<CreateTaskUseCase>(
        () => MockCreateTaskUseCase());
    getIt.registerLazySingleton<FetchTaskUseCase>(() => MockFetchTaskUseCase());
    getIt.registerLazySingleton<DeleteTaskUseCase>(
        () => MockDeleteTaskUseCase());

    getIt.registerFactory(() => TaskManagerBloc(
          createTaskUseCase: getIt(),
          fetchTasksUseCase: getIt(),
          deleteTaskUseCase: getIt(),
        ));
  });

  tearDown(() => getIt.reset());


  blocTest<TaskManagerBloc, TaskManagerState>(
    "should emit [loading, loaded] when fetchTasks is called successfully",
    build: () {
      when(() => getIt<FetchTaskUseCase>().call(any())).thenAnswer(
          (_) async => const Right([TaskModel(id: '1', title: 'Test Task')]));
      return getIt<TaskManagerBloc>();
    },
    act: (bloc) => bloc.add(FetchTasksEvent()),
    expect: () => [
      const TaskManagerState(status: TaskManagerStatus.loading),
      const TaskManagerState(
          status: TaskManagerStatus.loaded,
          tasks: [TaskModel(id: '1', title: 'Test Task')])
    ],
  );

  blocTest<TaskManagerBloc, TaskManagerState>(
    "should emit [loading, error] when fetchTasks fails",
    build: () {
      when(() => getIt<FetchTaskUseCase>().call(any()))
          .thenAnswer((_) async => Left(Exception('Failed to fetch tasks')));
      return getIt<TaskManagerBloc>();
    },
    act: (bloc) => bloc.add(FetchTasksEvent()),
    expect: () => [
      const TaskManagerState(status: TaskManagerStatus.loading),
      const TaskManagerState(
          status: TaskManagerStatus.error, exception: 'Failed to fetch tasks')
    ],
  );
blocTest<TaskManagerBloc, TaskManagerState>(
  'emits [loading, loaded] when task creation is successful',
  build: () {
    when(() => getIt<CreateTaskUseCase>().call(any()))
        .thenAnswer((_) async => const Right(unit));
    when(() => getIt<FetchTaskUseCase>().call(any()))
        .thenAnswer((_) async => const Right([])); 
    return getIt<TaskManagerBloc>();
  },
  act: (bloc) => bloc.add(const CreateTaskEvent(task: TaskModel(id: '1', title: 'New Task'))),
  expect: () => [
    const TaskManagerState(status: TaskManagerStatus.loading),
    const TaskManagerState(status: TaskManagerStatus.loaded)  
  ]
);

blocTest<TaskManagerBloc, TaskManagerState>(
  'emits [loading, error] when task creation fails',
  build: () {
    // Mock the failure in task creation
    when(() => getIt<CreateTaskUseCase>().call(any()))
        .thenAnswer((_) async => Left(Exception("Creation failed")));
    return getIt<TaskManagerBloc>();
  },
  act: (bloc) => bloc.add(const CreateTaskEvent(task: TaskModel(id: '2', title: 'Failed Task'))),
  expect: () => [
    const TaskManagerState(status: TaskManagerStatus.loading),  
    const TaskManagerState(status: TaskManagerStatus.error, exception: "Exception: Creation failed")  
  ]
);


  blocTest<TaskManagerBloc, TaskManagerState>(
  'emits [loading, loaded] when deletion is successful and fetches tasks',
  build: () {
    
    when(() => getIt<DeleteTaskUseCase>().call(any()))
        .thenAnswer((_) async => const Right(unit));
    when(() => getIt<FetchTaskUseCase>().call(any()))
        .thenAnswer((_) async => const Right([])); 
    return getIt<TaskManagerBloc>();
  },
  act: (bloc) => bloc.add(const DeleteTaskEvent(id: '1')),
  expect: () => [
    const TaskManagerState(status: TaskManagerStatus.loading),
    const TaskManagerState(status: TaskManagerStatus.loaded)  
  ]
);
blocTest<TaskManagerBloc, TaskManagerState>(
  'emits [loading, error] when deletion fails',
  build: () {
    
    when(() => getIt<DeleteTaskUseCase>().call('1')).thenAnswer((_) async => Left(Exception("Deletion failed")));
    return getIt<TaskManagerBloc>();
  },
  act: (bloc) => bloc.add(const DeleteTaskEvent(id: '1')),
  expect: () => [
    const TaskManagerState(status: TaskManagerStatus.loading), 
    const TaskManagerState(status: TaskManagerStatus.error, exception: "Exception: Deletion failed")
  ]
);


}
