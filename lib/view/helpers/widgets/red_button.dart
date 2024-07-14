// ignore_for_file: unnecessary_string_interpolations, unnecessary_brace_in_string_interps, sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rheal/view/AppColors.dart';

class RedButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPress;

  const RedButton({Key? key, required this.label, this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        child: Text('${label}',
            style: TextStyle(fontSize: 15, color: AppColors.text)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 211, 84, 84),
          padding: const EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: onPress,
      ),
    );
  }
} //end of widget
