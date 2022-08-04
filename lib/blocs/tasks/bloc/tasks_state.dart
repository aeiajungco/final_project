part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

class TaskManager extends TasksState {
  final List<Task> tasksList;
  final List<Task> deletedTasks;
  final List<Task> favoriteTasks;
  final List<Task> completedTasks;
  const TaskManager({
    this.tasksList = const <Task>[],
    this.deletedTasks = const <Task>[],
    this.favoriteTasks = const <Task>[],
    this.completedTasks = const <Task>[],
  });

  @override
  List<Object> get props =>
      [tasksList, deletedTasks, favoriteTasks, completedTasks];
}
