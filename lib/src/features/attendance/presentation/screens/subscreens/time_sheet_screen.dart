import 'package:flutter/material.dart';

import '../../../../../core/utils/app_strings.dart';

class TimeSheetScreen extends StatelessWidget {
  const TimeSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: const [
       Center(
        child: Text(AppStrings.timeSheetScreen),
      ),
    ]);
  }
}
