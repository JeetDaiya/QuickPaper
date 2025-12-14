import 'dart:ui';
import 'package:client/features/questions/providers/selected_questions_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/selected_question_info_provider.dart';
import '../widgets/question_tag.dart';

class SelectedQuestionsPreviewScreen extends ConsumerWidget {
  const SelectedQuestionsPreviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedQuestionsInfo = ref.watch(selectedQuestionsInfoProvider);
    final selectedQuestions = ref.watch(selectedQuestionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Paper Preview'),
            Row(
              children: [
                Text(
                    '${selectedQuestionsInfo.count} Questions',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600]
                  ),
                ),
                Text(
                    ' • ',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600]
                  ),
                ),
                Text(
                    '${selectedQuestionsInfo.marks} Marks',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600]
                  ),
                ),

              ],
            ),

          ]
        )
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '💡 Drag questions to reorder. ',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600]
              ),
            ),
            selectedQuestions.isEmpty
                ? const Center(child: Text("No questions selected"))
                : Expanded(
                  child: ReorderableListView.builder(
                              proxyDecorator: _proxyDecorator,
                              itemCount: selectedQuestions.length,


                              onReorder: (oldIndex, newIndex) {
                  if (oldIndex < newIndex) newIndex -= 1;
                  ref
                      .read(selectedQuestionsProvider.notifier)
                      .reorder(oldIndex, newIndex);
                              },

                              itemBuilder: (context, index) {
                  final question = selectedQuestions[index];
                  return Card(
                    key: ValueKey(question.id),
                    margin:
                    const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReorderableDragStartListener(
                            index: index,
                            child: const Icon(
                              Icons.drag_indicator_outlined,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Question ${index + 1}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Colors.grey[600]
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  question.text.trim(),
                                  softWrap: true,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Wrap(
                                      spacing: 6,
                                      children: [
                                        QuestionTag(
                                          question: question,
                                          backgroundColor: const Color(0xFFE0F2F1),
                                          textColor: const Color(0xFF00695C),
                                          info: "${question.marks} Marks",
                                        ),
                                        QuestionTag(
                                          question: question,
                                          backgroundColor: const Color(0xFFECEFF1),
                                          textColor: const Color(0xFF475569),
                                          info: question.questionType,
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete_outline),
                                      color: Colors.redAccent,
                                      onPressed: () {
                                        ref
                                            .read(selectedQuestionsProvider.notifier)
                                            .toggle(question);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                              },
                            ),
                ),
          ]
        ),
      )
    );
  }

  Widget _proxyDecorator(
      Widget child,
      int index,
      Animation<double> animation,
      ) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, child) {
        final elevation = lerpDouble(0, 8, animation.value)!;
        return Material(
          elevation: elevation,
          color: Colors.transparent,
          shadowColor: Colors.black54,
          child: child,
        );
      },
      child: child,
    );
  }
}
