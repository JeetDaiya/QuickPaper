import 'package:client/core/theme/app_pallete.dart';
import 'package:client/features/questions/providers/filtered_questions_provider.dart';
import 'package:client/features/questions/providers/marks_filter_provider.dart';
import 'package:client/features/questions/providers/selected_question_info_provider.dart';
import 'package:client/features/questions/providers/selected_questions_provider.dart';
import 'package:client/features/questions/view/selected_questions_preview_screen.dart';
import 'package:client/features/questions/viewmodel/question_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/marks_options_provider.dart';
import '../widgets/filter_bar.dart';
import '../widgets/question_card.dart';


// 1. Extend ConsumerWidget (not StatelessWidget)
class QuestionScreen extends ConsumerWidget {
  const QuestionScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 2. WATCH the Provider
    // This variable 'questionState' is an AsyncValue (it holds data, error, or loading)
    final questionState = ref.watch(filteredQuestionsProvider);
    final marksFilter = ref.watch(marksFilterProvider.select((value) => value));
    final selectedQuestionInfo = ref.watch(selectedQuestionsInfoProvider);
    final marksOptions = ref.watch(marksOptionsProvider);

    // 5. Use .when()
    return Scaffold(
      appBar: AppBar(
          title: const Text("Questions"),
        actions: selectedQuestionInfo.count > 0 ? [
          TextButton(
            onPressed: () {
              ref.read(selectedQuestionsProvider.notifier).clear();
            },
            child: const Text(
              'Clear',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ] : const [],

      ),

      // 3. Use .when() to handle the 3 states
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.symmetric(horizontal: BorderSide(color: Colors.grey, width: 0.75))
            ),
            child: Column(
              children: [
                FilterBar(label: 'Marks', options: marksOptions, onSelected: (value) => ref.read(marksFilterProvider.notifier).set(value), selected: marksFilter),
              ],
            ),
          ),
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
      bottomNavigationBar: selectedQuestionInfo.count > 0 ?
      SafeArea(
        child: Container(
          height: 100,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  top: BorderSide(
                      color: Colors.grey,
                      width: 2.0
                  )
              ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${selectedQuestionInfo.count} Questions Selected',
                    style: TextStyle(
                      fontSize: 16
                    )
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Total Marks: ${selectedQuestionInfo.marks}',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[600]
                    )
                  )
                ],
              ),
              Spacer(),
              TextButton(
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                    backgroundColor: WidgetStateProperty.all(Pallete.primaryColor),
                    shape: WidgetStateProperty.all(RoundedRectangleBorder( borderRadius: BorderRadius.circular(10) ))
                  ),
                  onPressed: () => { Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => SelectedQuestionsPreviewScreen()))
                  }, child: Text(
                  'Review Paper',
                  style: TextStyle(
                    color: Colors.white
                  ),
              )
              )
            ],
          ),
        ),
      ) : null,
    );
  }
}

