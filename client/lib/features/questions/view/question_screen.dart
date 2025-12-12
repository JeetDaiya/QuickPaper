import 'package:client/features/questions/providers/filtered_questions_provider.dart';
import 'package:client/features/questions/providers/marks_filter_provider.dart';
import 'package:client/features/questions/viewmodel/question_viewmodel.dart';
import 'package:client/features/questions/widgets/question_tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/hive/models/question_model.dart';
import '../widgets/filter_bar.dart';
import 'package:gpt_markdown/gpt_markdown.dart';

// 1. Extend ConsumerWidget (not StatelessWidget)
class QuestionScreen extends ConsumerWidget {
  const QuestionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 2. WATCH the Provider
    // This variable 'questionState' is an AsyncValue (it holds data, error, or loading)
    final questionState = ref.watch(filteredQuestionsProvider);
    final marksFilter = ref.watch(marksFilterProvider.select((value) => value));

    return Scaffold(
      appBar: AppBar(title: const Text("Questions")),

      // 3. Use .when() to handle the 3 states
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          FilterBar(label: 'Marks', options: ['All', '1', '2', '3', '4'], onSelected: (value) => ref.read(marksFilterProvider.notifier).set(value), selected: marksFilter),
          questionState.when(
            // CASE A: LOADING (Show spinner)
            loading: () => const Center(
                key: ValueKey("Loading"),
                child: CircularProgressIndicator()
            ),
            // CASE B: ERROR (Show red text)
            error: (error, stackTrace) => Center(
              key: ValueKey("error"),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Error: $error", style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => ref.read(questionViewmodelProvider.notifier).refresh(),
                    child: const Text("Retry"),
                  ),
                ],
              ),
            ),

            // CASE C: SUCCESS (Show the list)
            data: (questions) {
              if (questions.isEmpty) {
                return const Center(
                    key: ValueKey("Empty"),
                    child: Text("No questions found.")
                );
              }
              // 4. Wrap in RefreshIndicator for Pull-to-Refresh support
              return Expanded(
                child: RefreshIndicator(
                  onRefresh: () => ref.read(questionViewmodelProvider.notifier).refresh(),
                  child: ListView.builder(
                    itemCount: questions.length,
                    itemBuilder: (context, index) {
                      final question = questions[index];
                      return QuestionCard(question: question);
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Keep your list items separate for clean code
class QuestionCard extends StatelessWidget {
  final Question question;
  const QuestionCard({required this.question, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          children: [
            GptMarkdown(
                question.text,

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
              ],
            )
          ],
        ),
      )
    );
  }
}