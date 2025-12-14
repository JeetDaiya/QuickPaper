import 'package:client/core/hive/models/question_model.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/features/questions/widgets/question_tag.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:gpt_markdown/gpt_markdown.dart';

import '../providers/selected_questions_provider.dart';

class QuestionCard extends ConsumerWidget {
  final Question question;
  const QuestionCard({super.key, required this.question});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedQuestions = ref.watch(selectedQuestionsProvider);
    final isSelected = selectedQuestions.contains(question);
    return Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: isSelected ? RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Pallete.primaryColor,
            width: 1.0
          )
        ) : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                question.text.trim(),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    children: [
                      QuestionTag(question: question, backgroundColor: Color(0xFFE0F2F1), textColor: Color(0xFF00695C), info: '${question.marks.toString()} Marks'),
                      const SizedBox(width: 5),
                      QuestionTag(question: question, backgroundColor: Color(0xFFECEFF1), textColor: Color(0xFF475569), info: question.questionType),
                    ],
                  ),
                  GestureDetector(
                    onTap: (){
                      ref.read(selectedQuestionsProvider.notifier).toggle(question);
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: isSelected? Colors.green : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Icon(
                        isSelected ? Icons.check_outlined : Icons.add_outlined,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
    );
  }
}
