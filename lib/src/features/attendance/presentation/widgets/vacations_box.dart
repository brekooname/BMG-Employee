
import 'package:flutter/material.dart';
import 'package:project_template/src/core/utils/media_query_values.dart';

import '../../../../core/decoration/box_decoration.dart';

class VacationBox extends StatelessWidget {
  final String vacation;
  final int vacationLeft;
  const VacationBox({super.key, required this.vacationLeft, required this.vacation});

  @override
  Widget build(BuildContext context) {
    final textTheme=Theme.of(context).textTheme;
    return Container(
      decoration: boxDecoration,
      padding: EdgeInsets.all(context.width*.02),
      // width: context.width*.3,
      constraints: BoxConstraints(
        minWidth: context.width*.35,
      ),
      child: Column(
        children: [
          Text(vacation,style:textTheme.headline3!.copyWith(color: Colors.black) ,),
          Text(vacationLeft.toString(),style: textTheme.headline3,),
        ],
      ),
    );
  }
}