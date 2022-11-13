import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project_template/src/core/utils/media_query_values.dart';
import '../../../../../core/decoration/box_decoration.dart';
import '../../../../../core/shared/shared.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/widgets/date_picker.dart';
import '../../../../../core/widgets/main_screen_padding.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  int? _date;
  int? _time;

  String get date {
    _date ??= DateTime.now().microsecondsSinceEpoch;
    return DateFormat()
        .add_yMMMMEEEEd()
        .format(DatePicker.readTimestamp(_date!));
  }

  String get time {
    _time ??= DateTime.now().microsecondsSinceEpoch;
    return DateFormat().add_Hm().format(DatePicker.readTimestamp(_time!));
  }

  String get greeting{
    final now=TimeOfDay.now().hour;
    String greetingString="";
    if( now>=6 && now<10){
       greetingString=AppStrings.morning;
    }else if(now>=10 && now<4){
      greetingString=AppStrings.afternoon;
    }else{
      greetingString=AppStrings.evening;
    }
    return "$greetingString ${currentUser!.userName??"Bro"}";
  }

  @override
  Widget build(BuildContext context) {
    return MainScreenPadding(children: [
      Text(greeting,style: Theme.of(context).textTheme.headline2,),
       SizedBox(height: context.verticalSpace,),
      Container(
        decoration: boxDecoration,
        child: Column(
          children: [
            TextButton(
                child: Text(date),
                onPressed: () async {
                  final pickedDate = await DatePicker.pickDate(
                    context: context,
                  );
                  if (pickedDate != null) {
                    setState(() => _date = pickedDate);
                  }
                }),
            TextButton(
                child: Text(time),
                onPressed: () async {
                  final pickedTime = await DatePicker.pickTime(
                    context: context,
                  );
                  if(pickedTime !=null){
                   setState(() => _time = pickedTime); 
                  }
                }),
          ],
        ),
      ),
    ]);
  }
}
