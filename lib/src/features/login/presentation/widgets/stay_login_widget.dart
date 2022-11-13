import 'package:flutter/material.dart';
import 'package:project_template/src/core/utils/media_query_values.dart';
import '../../../../core/constant/constant.dart';
import '../../../../core/shared/shared.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/horizontal_sized_box.dart';

class StayLoginWidget extends StatefulWidget {
  const StayLoginWidget({super.key});

  @override
  State<StayLoginWidget> createState() => _StayLoginWidgetState();
}

class _StayLoginWidgetState extends State<StayLoginWidget> {
  bool _stayLogin = false;

  bool get stayLogin {
    return _stayLogin;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _stayLogin = !_stayLogin;
          shouldStayLogin = stayLogin;
        });
      },
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(stayLogin ? Icons.check_box : Icons.check_box_outline_blank,color: Theme.of(context).primaryColor,size:Constant.isWindows()?context.width*.04: context.width * .07,),
          const HorizontalSizedBox(),
          const Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: Text(
              AppStrings.stayLogin,
            ),
          ),
        ],
      ),
    );
  }
}
