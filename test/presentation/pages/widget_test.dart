import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_manager_app/presentation/bloc/task_manager_bloc.dart';
import 'package:task_manager_app/presentation/pages/task_creation_page.dart';

class MockTaskManagerBloc extends MockBloc<TaskManagerEvent, TaskManagerState> implements TaskManagerBloc {}
class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late MockTaskManagerBloc mockBloc;
  late MockNavigatorObserver mockNavigatorObserver;

  setUpAll(() {
    registerFallbackValue(FakeTaskManagerEvent());
    registerFallbackValue(FakeRoute<dynamic>());
  });

  setUp(() {
    mockBloc = MockTaskManagerBloc();
    mockNavigatorObserver = MockNavigatorObserver();
  });

  tearDown(() {
    mockBloc.close();
  });

  Widget createWidgetUnderTest() {
    return  BlocProvider<TaskManagerBloc>(
        create: (_) => mockBloc,
        child:   MaterialApp(home: TaskCreationPage(),navigatorObservers: [mockNavigatorObserver]),
      );
  }

  testWidgets('Does not submit form when title is empty', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    verifyNever(() => mockBloc.add(any()));
    expect(find.text('Please enter a title'), findsOneWidget);
  });

  testWidgets('Submits form and adds CreateTaskEvent when title is provided', (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TaskManagerState());
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.enterText(find.byType(TextFormField), 'New Task');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    verify(() => mockBloc.add(any(that: isA<CreateTaskEvent>()))).called(1);
  });


}

class FakeTaskManagerEvent extends Fake implements TaskManagerEvent {}
class FakeRoute<T> extends Fake implements Route<T> {}
