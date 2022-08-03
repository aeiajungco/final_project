import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/task.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<ShowTasks>(_onShowTasks);
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
  }

  void _onShowTasks(ShowTasks event, Emitter<TasksState> emit) {
    emit(TasksState(tasksList: event.tasksList));
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;

    emit(TasksState(tasksList: List.from(state.tasksList)..add(event.task)));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {}
  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {}
}
