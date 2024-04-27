import 'package:get_it/get_it.dart';

import '../data/source/task_manager_data_source.dart';
import '../data/source/task_manager_data_source_implementation.dart';
import '../domain/repository/task_manager_repository.dart';
import '../domain/repository/task_manager_repository_implementation.dart';
import '../domain/usecases/create_task_usecase.dart';
import '../domain/usecases/delete_task_usecase.dart';
import '../domain/usecases/fetch_task_usecase.dart';
import '../presentation/bloc/task_manager_bloc.dart';

final GetIt locator = GetIt.instance;

/// Initializes and configures the service locator [GetIt] for dependency injection across the application.
///
/// This function `setupLocator` is pivotal for setting up the dependency injection mechanism,
/// ensuring that different layers of the application architecture—such as data sources,
/// repositories, use cases, and blocs—are properly instantiated and available where needed.
/// By utilizing [GetIt] as a service locator, the application can maintain a clean, scalable,
/// and testable architecture by managing dependencies centrally and efficiently.
///
/// Benefits of Using GetIt with Flutter Bloc in Clean Architecture:
/// - **Decoupling**: Components are less dependent on the specifics of other components' constructions.
/// - **Reusability**: Provides a consistent and centralized way to manage object lifecycles and reuse.
/// - **Testability**: Simplifies mocking and overriding specific parts of the system for testing purposes.
/// - **Maintainability**: Enhances the maintainability of the application by centralizing the configuration of dependencies.
///
/// Components Registered:
/// - `TaskManagerDataSource`: Manages data operations. It is registered as a lazy singleton to ensure
///   that only one instance exists throughout the app lifecycle, promoting resource efficiency.
/// - `TaskManagerRepository`: Abstracts the data layer by communicating with the data source. It uses
///   the data source instance provided by GetIt.
/// - Use Cases: Encapsulate business logic for creating, deleting, and fetching tasks. Each use case
///   is dependent on the repository, ensuring separation of concerns.
/// - `TaskManagerBloc`: Facilitates state management across the application. Registered as a factory
///   to create a new instance every time it is needed, which helps in managing state appropriately
///   across different parts of the app.
///
/// Usage Example:
/// To fetch a repository instance anywhere in the app, use `locator<TaskManagerRepository>()`.

void setupLocator() {
  // Registering the data source as a lazy singleton ensures that it is created only once when first needed.
  locator.registerLazySingleton<TaskManagerDataSource>(
      () => TaskManagerDataSourceImplementation());

  // Repositories are also registered as lazy singletons, promoting efficient use of resources by reusing the instance.
  locator.registerLazySingleton<TaskManagerRepository>(() =>
      TaskManagerRepositoryImplementation(dataSource: locator<TaskManagerDataSource>()));

  // Use cases are registered as lazy singletons for consistent reuse throughout the application,
  // ensuring that the business logic remains stateless and predictable.
  locator.registerLazySingleton(
      () => CreateTaskUseCase(repository: locator<TaskManagerRepository>()));
  locator.registerLazySingleton(
      () => FetchTaskUseCase(repository: locator<TaskManagerRepository>()));
  locator.registerLazySingleton(
      () => DeleteTaskUseCase(repository: locator<TaskManagerRepository>()));

  // The Bloc is registered as a factory. Each use case integration into the bloc ensures that
  // the bloc can manage state based on current business logic needs.
  locator.registerFactory(() => TaskManagerBloc(
      createTaskUseCase: locator<CreateTaskUseCase>(),
      fetchTasksUseCase: locator<FetchTaskUseCase>(),
      deleteTaskUseCase: locator<DeleteTaskUseCase>())
    ..add(FetchTasksEvent()));
}
