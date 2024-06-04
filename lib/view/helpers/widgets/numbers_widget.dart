// ignore_for_file: prefer_typing_uninitialized_variables, use_key_in_widget_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';

class NumbersWidget extends StatefulWidget {
  const NumbersWidget(
      {required this.isActiv, required this.type, required this.country});
  final isActiv;
  final type;
  final country;
  @override
  State<NumbersWidget> createState() => _NumbersWidgetState();
}

class _NumbersWidgetState extends State<NumbersWidget> {
  @override
  Widget build(
    BuildContext context,
  ) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildButton(context, 'حالة الحساب',
              '${widget.isActiv == 0 ? 'غير مفعل' : 'مفعل'}', widget.isActiv),
          buildDivider(),
          buildButton(context, 'البلد', '${widget.country}', 1),
          buildDivider(),
          buildButton(context, 'نوع الحساب',
              '${widget.type == 1 ? 'مستشار' : 'مستخدم'}', 1),
        ],
      );

  Widget buildDivider() => const SizedBox(
        height: 24,
        child: VerticalDivider(),
      );

  Widget buildButton(
          BuildContext context, String value, String text, int type) =>
      MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            const SizedBox(height: 2),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: type == 0 ? Colors.redAccent : Colors.green,
              ),
            ),
          ],
        ),
      );
}
