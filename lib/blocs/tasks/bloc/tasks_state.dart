part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  final List<Task> tasksList;
  const TasksState({this.tasksList = const <Task>[]});

  @override
  List<Object> get props => [tasksList];
}
