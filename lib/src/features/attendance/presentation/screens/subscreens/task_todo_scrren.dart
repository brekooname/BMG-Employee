import 'package:flutter/material.dart';

import '../../../../../core/utils/app_strings.dart';

class TaskToDoScreen extends StatelessWidget {
  const TaskToDoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: const [
       Center(
        child: Text(AppStrings.taskToDoScreen),
      ),
    ]);
  }
}
