import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/hive/models/question_model.dart';

class QuestionTag extends ConsumerWidget {
  final Question question;
  final Color backgroundColor;
  final Color textColor;
  final String info;

  const QuestionTag({super.key, required this.question, required this.backgroundColor, required this.textColor, required this.info});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: backgroundColor
      ),
      child: Text(
        info,
        style: TextStyle(
            color: textColor,
                fontSize: 12.0
        ),
      ),
    );
  }
}
