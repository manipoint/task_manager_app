import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager_app/data/source/task_manager_data_source.dart';
import 'package:task_manager_app/domain/repository/task_manager_repository.dart';
import 'package:task_manager_app/domain/repository/task_manager_repository_implementation.dart';

import '../data/source/task_manager_data_source_implementation_test.dart';


class MockTaskManagerDataSource extends Mock implements TaskManagerDataSource {}

void setupTestDependencies() {
  final getIt = GetIt.instance;

  // Ensures GetIt is properly cleared before setting up any mocks
  getIt.reset();

  // Register all the mocks
  getIt.registerLazySingleton<TaskManagerDataSource>(() => MockTaskManagerDataSourceImplementation());

  // Setup repository with the mock data source
  getIt.registerLazySingleton<TaskManagerRepository>(
    () => TaskManagerRepositoryImplementation(dataSource: getIt()),
  );
}
