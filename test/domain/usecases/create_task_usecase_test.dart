import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/source/task_manager_data_source.dart';
import 'package:task_manager_app/domain/repository/task_manager_repository.dart';
import 'package:task_manager_app/domain/repository/task_manager_repository_implementation.dart';
import 'package:task_manager_app/domain/usecases/create_task_usecase.dart';

class MockTaskManagerDataSource extends Mock implements TaskManagerDataSource {}
class MockTaskManagerRepository extends Mock implements TaskManagerRepository {}

void setupTestDependencies() {
  final getIt = GetIt.instance;

  getIt.reset();

  // Register all the mocks
  getIt.registerLazySingleton<TaskManagerDataSource>(() => MockTaskManagerDataSource());
  getIt.registerLazySingleton<TaskManagerRepository>(
    () => TaskManagerRepositoryImplementation(dataSource: getIt<TaskManagerDataSource>()),
  );
}

void main() {
  late CreateTaskUseCase createTaskUseCase;
  late MockTaskManagerRepository mockRepository;

  setUp(() {
    setupTestDependencies();
    mockRepository = GetIt.instance<TaskManagerRepository>() as MockTaskManagerRepository;
    createTaskUseCase = CreateTaskUseCase(repository: mockRepository);
  });

  test('CreateTaskUseCase should successfully create a task', () async {
    // Arrange
    const task = TaskModel(id: '1', title: 'Test Task');
    when(mockRepository.createTask(task)).thenAnswer((_) async => Right(unit));

    // Act
    final result = await createTaskUseCase(task);

    // Assert
    expect(result, const Right(unit));
    verify(mockRepository.createTask(task)).called(1);
  });

  test('CreateTaskUseCase should handle errors when creating a task', () async {
    // Arrange
    const task = TaskModel(id: '1', title: 'Test Task');
    final exception = Exception('Failed to create task');
    when(mockRepository.createTask(task)).thenAnswer((_) async => Left(exception));

    // Act
    final result = await createTaskUseCase(task);

    // Assert
    expect(result, Left(exception));
    verify(mockRepository.createTask(task)).called(1);
  });
}
