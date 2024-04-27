// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/source/task_manager_data_source.dart';
import 'package:task_manager_app/domain/repository/task_manager_repository.dart';


import '../../helper/test_helper.dart';


void main() {
  setUp(() {
    // Setup the test dependencies before each test
    setupTestDependencies();
  });

  test('createTask should return Right(Unit) when data source succeeds', () async {
    // Arrange
    final repository = GetIt.instance<TaskManagerRepository>();
    final dataSource = GetIt.instance<TaskManagerDataSource>();

    const testTask = TaskModel(id: '1', title: 'Test Task');
    when(dataSource.createTask(testTask)).thenAnswer((_) async => Right(unit));

    // Act
    final result = await repository.createTask(testTask);

    // Assert
    expect(result, const Right(unit));
    verify(dataSource.createTask(testTask)).called(1);
  });
 test('fetchTasks should return Right(List<TaskModel>) when data source succeeds', () async {
  // Arrange
  final repository = GetIt.instance<TaskManagerRepository>();
  final dataSource = GetIt.instance<TaskManagerDataSource>();
  final testTasks = [const TaskModel(id: '1', title: 'Test Task')];
  when(dataSource.fetchTasks()).thenAnswer((_) async => Right(testTasks));

  // Act
  final result = await repository.fetchTasks();

  // Assert
  expect(result, Right(testTasks));
  verify(dataSource.fetchTasks()).called(1);
});
test('deleteTask should return Right(Unit) when data source succeeds', () async {
  // Arrange
  final repository = GetIt.instance<TaskManagerRepository>();
  final dataSource = GetIt.instance<TaskManagerDataSource>();
  const taskId = '1';
  when(dataSource.deleteTask(taskId)).thenAnswer((_) async => Right(unit));

  // Act
  final result = await repository.deleteTask(taskId);

  // Assert
  expect(result, const Right(unit));
  verify(dataSource.deleteTask(taskId)).called(1);
});

 
}
