import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/source/task_manager_data_source_implementation.dart';

class MockTaskManagerDataSourceImplementation extends Mock implements TaskManagerDataSourceImplementation {
  @override
  Future<Either<Exception, Unit>> createTask(TaskModel task) {
    return super.noSuchMethod(
      Invocation.method(#createTask, [task]),
      returnValue: Future.value(const Right<Exception, Unit>(unit)),
      returnValueForMissingStub: Future.value(Left(Exception('Method not stubbed'))),
    );
  }

  @override
  Future<Either<Exception, Unit>> deleteTask(String id) {
    return super.noSuchMethod(
      Invocation.method(#deleteTask, [id]),
      returnValue: Future.value(const Right<Exception, Unit>(unit)),
      returnValueForMissingStub: Future.value(Left(Exception('Method not stubbed'))),
    );
  }

  @override
  Future<Either<Exception, List<TaskModel>>> fetchTasks() {
    return super.noSuchMethod(
      Invocation.method(#fetchTasks, []),
      returnValue: Future.value(const Right<Exception, List<TaskModel>>([])),
      returnValueForMissingStub: Future.value(Left(Exception('Method not stubbed'))),
    );
  }
}

void main() {
  late TaskManagerDataSourceImplementation dataSource;
  late MockTaskManagerDataSourceImplementation mockDataSource;

  setUp(() {
    mockDataSource = MockTaskManagerDataSourceImplementation();
    dataSource = mockDataSource;
  });

  const task = TaskModel(id: '1', title: 'Test Task');

  // Test for creating a task
  test('should create a task and return Right(unit) on success', () async {
    when(mockDataSource.createTask(task)).thenAnswer((_) async => const Right<Exception, Unit>(unit));
    final result = await dataSource.createTask(task);
    expect(result, const Right(unit));
    verify(mockDataSource.createTask(task)).called(1);
  });

  // Test for deleting a task
  test('should delete a task and return Right(unit) on success', () async {
    when(mockDataSource.deleteTask(task.id)).thenAnswer((_) async => const Right<Exception, Unit>(unit));
    final result = await dataSource.deleteTask(task.id);
    expect(result, const Right(unit));
    verify(mockDataSource.deleteTask(task.id)).called(1);
  });

  // Test for failing to delete a task
  test('should return Left(Exception) when deletion fails', () async {
    when(mockDataSource.deleteTask(task.id)).thenAnswer((_) async => Left(Exception('Failed to delete task')));
    final result = await dataSource.deleteTask(task.id);
    expect(result, isA<Left>());
    result.fold(
      (l) => expect(l, isA<Exception>()),
      (r) => fail('Expected failure'),
    );
  });

// Test for fetching all tasks
test('should fetch all tasks and return Right(list) on success', () async {
  const task = TaskModel(id: '1', title: 'Test Task'); // The task instance
  // Ensure the list you return from the mock is exactly what you expect
  List<TaskModel> expectedTasks = [task];

  // Mock the method call to return a Right containing a list of TaskModel
  when(mockDataSource.fetchTasks()).thenAnswer((_) async => Right<Exception, List<TaskModel>>(expectedTasks));

  // Call the actual method
  final result = await dataSource.fetchTasks();

  // Use the `equals` matcher to compare the results
  expect(result, equals(Right<Exception, List<TaskModel>>(expectedTasks)));

  verify(mockDataSource.fetchTasks()).called(1);
});


  // Test for failing to fetch tasks
  test('should return Left(Exception) when fetch fails', () async {
    when(mockDataSource.fetchTasks()).thenAnswer((_) async => Left(Exception('Failed to fetch tasks')));
    final result = await dataSource.fetchTasks();
    expect(result, isA<Left>());
    result.fold(
      (l) => expect(l, isA<Exception>()),
      (r) => fail('Expected failure'),
    );
  });
}
