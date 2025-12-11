import 'package:client/features/questions/viewmodel/question_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/hive/models/question_model.dart';

// 1. Extend ConsumerWidget (not StatelessWidget)
class QuestionScreen extends ConsumerWidget {
  const QuestionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 2. WATCH the Provider
    // This variable 'questionState' is an AsyncValue (it holds data, error, or loading)
    final questionState = ref.watch(questionViewmodelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Questions")),

      // 3. Use .when() to handle the 3 states
      body: questionState.when(
        // CASE A: LOADING (Show spinner)
        loading: () => const Center(child: CircularProgressIndicator()),

        // CASE B: ERROR (Show red text)
        error: (error, stackTrace) => Center(
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
            return const Center(child: Text("No questions found."));
          }

          // 4. Wrap in RefreshIndicator for Pull-to-Refresh support
          return RefreshIndicator(
            onRefresh: () => ref.read(questionViewmodelProvider.notifier).refresh(),
            child: ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final question = questions[index];
                return QuestionCard(question: question);
              },
            ),
          );
        },
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
      child: ListTile(
        leading: CircleAvatar(
          child: Text(question.marks.toString()),
        ),
        title: Text(question.text),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}