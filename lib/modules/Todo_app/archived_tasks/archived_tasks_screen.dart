import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/Todo_app/cubit/cubit.dart';
import 'package:todo_app/layout/Todo_app/cubit/states.dart';
import 'package:todo_app/share/components/companents.dart';


class  ArchivedTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer < AppCubit, AppStates>(
        listener: (context,state){},
        builder: (context,state) {
          var tasks = AppCubit().get(context).newTasks;
          return ListView.separated(
            itemBuilder: (context, index) => builtTaskItem(tasks[index], context ),
            separatorBuilder: (context, index) =>Padding(
              padding: const EdgeInsetsDirectional.only(start: 20,),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            itemCount: tasks.length,
          );
        }
    );
  }
}
