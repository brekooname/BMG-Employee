import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:project_template/src/core/utils/app_strings.dart';
import 'package:project_template/src/core/utils/media_query_values.dart';

class TableCellWidget extends StatelessWidget {
  final Either<String, IconData> content;
  final int flex;
  final VoidCallback? onPressed;
  const TableCellWidget({Key? key, required this.content, this.onPressed, this.flex=1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String text = "";
    IconData? icon;
    content.fold(
      (txt) => text = txt,
      (iconData) => icon = iconData,
    );
    return Flexible(
      flex: flex,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: Center(
            child: TextButton(
              onPressed: onPressed,
              child: (icon != null)
                  ? Icon(icon)
                  : Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: context.width*.02,
                          color: Colors.black,
                      ),
                      maxLines: 1,
                    ),
            )),
      ),
    );
  }
}
