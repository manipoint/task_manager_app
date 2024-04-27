import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager_app/data/models/task_model.dart';

void main() {
  group('TaskModel', () {
    test('supports value comparison', () {
      expect(const TaskModel(id: '1', title: 'Task 1'), const TaskModel(id: '1', title: 'Task 1'));
    });

    test('converts to map correctly', () {
      var task = const TaskModel(id: '1', title: 'Task 1');
      expect(task.toMap(), {
        'id': '1',
        'title': 'Task 1'
      });
    });

    test('creates from map', () {
      var map = {'id': '1', 'title': 'Task 1'};
      expect(TaskModel.fromMap(map), const TaskModel(id: '1', title: 'Task 1'));
    });

    test('converts to JSON correctly', () {
      var task = const TaskModel(id: '1', title: 'Task 1');
      String json = '{"id":"1","title":"Task 1"}';
      expect(task.toJson(), json);
    });

    test('creates from JSON', () {
      String json = '{"id":"1","title":"Task 1"}';
      expect(TaskModel.fromJson(json), const TaskModel(id: '1', title: 'Task 1'));
    });
  });
}
