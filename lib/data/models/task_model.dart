
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'task_model.g.dart';

/// Represents a Task Model for the application.
///
/// This class is used to store task information,
/// with properties [id] and [title]. It extends [Equatable],
/// allowing comparison of instances of this class.
///
/// Parameters:
/// - [id]: A unique identifier for the task.
/// - [title]: The title of the task.
///
/// Methods:
/// - [toMap]: Converts the instance into a map representation.
/// - [fromMap]: Creates an instance from a map.
/// - [toJson]: Converts the instance into a JSON string.
/// - [fromJson]: Creates an instance from a JSON string.
///
/// {@category Model}
@HiveType(typeId: 0) 
class TaskModel extends Equatable {
  const TaskModel({required this.id,required this.title});
 @HiveField(0)
  final String id;
 @HiveField(1)
  final String title;

  @override
  List<Object> get props => [id, title];

  /// Converts the instance into a map representation.
  ///
  /// Returns a [Map] with keys 'id' and 'title',
  /// corresponding to the values of [id] and [title] respectively.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
    };
  }

  /// Creates an instance from a map.
  ///
  /// The map should have keys 'id' and 'title'.
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as String,
      title: map['title'] as String,
    );
  }

  /// Converts the instance into a JSON string.
  String toJson() => json.encode(toMap());

  /// Creates an instance from a JSON string.
  factory TaskModel.fromJson(String source) => TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
