import 'package:flutter/material.dart';
import 'package:project_template/src/core/utils/media_query_values.dart';

class TextFormWidget extends StatelessWidget {
  final String labelText;
  final String? Function(String?) validatorFunc;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final int maxLines;
  final bool obscure;
  final String hint;
  final Widget icon;
  final Widget prefix;
  final Widget suffix;
  final bool enabled;

  const TextFormWidget(
      {Key? key,
      required this.labelText,
      required this.validatorFunc,
      required this.textEditingController,
      this.textInputType = TextInputType.text,
      this.maxLines = 1,
      this.obscure = false,
      this.hint = "",
      this.icon = const SizedBox(),
      this.prefix = const SizedBox(),
      this.suffix = const SizedBox(),
      this.enabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: Theme.of(context).textTheme.headline5!.copyWith(
                fontSize: context.fontSizeNormal,
              ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          enabled: enabled,
          validator: validatorFunc,
          obscureText: obscure,
          controller: textEditingController,
          maxLines: maxLines,
          keyboardType: textInputType,
          decoration: InputDecoration(
            // labelText: labelText,
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            prefixIcon: prefix,
            suffixIcon: suffix,
            icon: icon,
            labelStyle: Theme.of(context).textTheme.headline5!.copyWith(
                  fontSize: context.fontSizeNormal,
                ),
              errorMaxLines: 2,
          ),
        ),
      ],
    );
  }
}
