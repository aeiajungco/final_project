import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/filter.dart';
import '../../../models/task.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TaskManager> {
  TasksBloc() : super(const TaskManager()) {
    on<ShowTasks>(_onShowTasks);
    on<AddTask>(_onAddTask);
    on<EditTask>(_onEditTask);
    on<DeleteTask>(_onDeleteTask);
    on<PermaDeleteTask>(_onPermaDeleteTask);
    on<RestoreTask>(_onRestoreTask);
    on<FavoriteTask>(_onFavoriteTask);
    on<CompleteTask>(_onCompleteTask);
  }

  void _onShowTasks(ShowTasks event, Emitter<TasksState> emit) {
    emit(TaskManager(
        tasksList: event.tasksList,
        deletedTasks: List.from(state.deletedTasks),
        completedTasks: List.from(state.completedTasks),
        favoriteTasks: List.from(state.favoriteTasks)));
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;

    emit(TaskManager(
        tasksList: List.from(state.tasksList)..add(event.task),
        deletedTasks: List.from(state.deletedTasks),
        completedTasks: List.from(state.completedTasks),
        favoriteTasks: List.from(state.favoriteTasks)));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;

    List<Task> tasksList = state.tasksList.where((task) {
      return task.id != event.task.id;
    }).toList();

    emit(TaskManager(
        tasksList: tasksList,
        deletedTasks: List.from(state.deletedTasks)..add(event.task),
        completedTasks: List.from(state.completedTasks),
        favoriteTasks: List.from(state.favoriteTasks)));
  }

  void _onPermaDeleteTask(PermaDeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;

    List<Task> deletedTasks = state.deletedTasks.where((task) {
      return task.id != event.task.id;
    }).toList();

    emit(TaskManager(
        tasksList: List.from(state.tasksList),
        deletedTasks: deletedTasks,
        completedTasks: List.from(state.completedTasks),
        favoriteTasks: List.from(state.favoriteTasks)));
  }

  void _onEditTask(EditTask event, Emitter<TasksState> emit) {
    final state = this.state;

    List<Task> tasksList = state.tasksList.map((task) {
      // task.copyWith(isDeleted: true);
      return task.id == event.task.id ? event.task : task;
    }).toList();

    emit(TaskManager(
        tasksList: tasksList,
        deletedTasks: List.from(state.deletedTasks),
        completedTasks: List.from(state.completedTasks),
        favoriteTasks: List.from(state.favoriteTasks)));
  }

  void _onRestoreTask(RestoreTask event, Emitter<TasksState> emit) {
    final state = this.state;

    List<Task> deletedTasks = state.deletedTasks.where((task) {
      return task.id != event.task.id;
    }).toList();

    emit(TaskManager(
        tasksList: List.from(state.tasksList)..add(event.task),
        deletedTasks: deletedTasks,
        completedTasks: List.from(state.completedTasks),
        favoriteTasks: List.from(state.favoriteTasks)));
  }

  void _onFavoriteTask(FavoriteTask event, Emitter<TasksState> emit) {
    final state = this.state;

    List<Task> tasksList = state.tasksList.map((task) {
      return task.id == event.task.id ? event.task : task;
    }).toList();

    if (event.status == true) {
      List<Task> favoriteTasks = state.favoriteTasks.where((task) {
        return task.id != event.task.id;
      }).toList();
      emit(TaskManager(
          tasksList: tasksList,
          deletedTasks: List.from(state.deletedTasks),
          completedTasks: List.from(state.completedTasks),
          favoriteTasks: favoriteTasks));
    } else {
      emit(TaskManager(
          tasksList: tasksList,
          deletedTasks: List.from(state.deletedTasks),
          completedTasks: List.from(state.completedTasks),
          favoriteTasks: List.from(state.favoriteTasks)..add(event.task)));
    }
  }

  void _onCompleteTask(CompleteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> tasksList = state.tasksList.where((task) {
      return task.id != event.task.id;
    }).toList();

    if (event.status == true) {
      List<Task> completedTasks = state.completedTasks.where((task) {
        return task.id != event.task.id;
      }).toList();
      emit(TaskManager(
          tasksList: tasksList..add(event.task),
          deletedTasks: List.from(state.deletedTasks),
          completedTasks: completedTasks,
          favoriteTasks: List.from(state.favoriteTasks)));
    } else {
      emit(TaskManager(
          tasksList: tasksList,
          deletedTasks: List.from(state.deletedTasks),
          completedTasks: List.from(state.completedTasks)..add(event.task),
          favoriteTasks: List.from(state.favoriteTasks)));
    }
  }
}
