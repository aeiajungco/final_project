import 'package:bloc_finals_exam/blocs/tasks/bloc/tasks_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/task.dart';
import 'add_edit_task.dart';
import 'popup_menu.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({Key? key, required this.task}) : super(key: key);

  final Task task;

  _editTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AddEditTask(task: task),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TaskManager>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: Row(
                children: [
                  !task.isFavorite!
                      ? const Icon(Icons.star_outline)
                      : const Icon(Icons.star),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            decoration: task.isDone!
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        Text(
                          DateFormat()
                              .add_yMMMd()
                              .add_Hms()
                              .format(DateTime.parse(task.createdAt!)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Checkbox(
                    value: task.isDone!,
                    onChanged: (value) {
                      task.isDeleted!
                          ? null
                          : context.read<TasksBloc>().add(CompleteTask(
                              task: task.copyWith(isDone: !task.isDone!),
                              status: task.isDone!));
                    }),
                PopupMenu(
                  task: task,
                  editCallback: () {
                    _editTask(context);
                    Navigator.pop(context);
                  },
                  likeOrDislikeCallback: () {
                    context.read<TasksBloc>().add(FavoriteTask(
                        task: task.copyWith(isFavorite: !task.isFavorite!),
                        status: task.isFavorite!));

                    print('favorite is ${task.isFavorite}');
                  },
                  cancelOrDeleteCallback: () {
                    !task.isDeleted!
                        ? context.read<TasksBloc>().add(
                            DeleteTask(task: task.copyWith(isDeleted: true)))
                        : context
                            .read<TasksBloc>()
                            .add(PermaDeleteTask(task: task));
                    print('task is ${task.isDeleted}');
                  },
                  restoreTaskCallback: () {
                    context.read<TasksBloc>().add(
                        RestoreTask(task: task.copyWith(isDeleted: false)));
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
