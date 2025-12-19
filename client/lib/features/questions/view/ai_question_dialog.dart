import 'package:client/features/questions/viewmodel/ai_question_viewmodel.dart';
import 'package:client/features/subject/providers/selected_subject_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/hive/models/question_model.dart';
import '../../subject/domain/subject.dart';
import '../widgets/question_card.dart';

const List<String> chapters = [
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '10',
];

class AiQuestionDialog extends ConsumerStatefulWidget {
  const AiQuestionDialog({super.key});

  @override
  ConsumerState createState() => _AiQuestionDialogState();
}

class _AiQuestionDialogState extends ConsumerState<AiQuestionDialog> {
  String _selectedChapter = chapters[0];
  @override
  Widget build(BuildContext context) {
    final aiState = ref.watch(
        aiQuestionViewmodelProvider
    );
    final selectedSubject = ref.watch(selectedSubjectProvider);
    final subjectString = selectedSubject?.apiKey;
    final hasQuestions = aiState.when(
      data: (q) => q.isNotEmpty,
      loading: () => false,
      error: (_, st) => false,
    );

    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(16),
        constraints: BoxConstraints(
          maxHeight: hasQuestions
              ? MediaQuery.of(context).size.height * 0.8
              : MediaQuery.of(context).size.height * 0.33 ,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.09,
              child: Row(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ImageIcon(
                          const AssetImage('assets/images/ai_generated.png'),
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'AI Question Generator',
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Generate new questions with AI!',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.close, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Select Chapter', textAlign: TextAlign.left,),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity, // <--- Sets the width of the button AND the menu
                      child: DropdownButtonFormField<String>(
                        // 2. Essential for proper width behavior
                        isExpanded: true,

                        // 3. Styling the Popup Menu itself
                        menuMaxHeight: 300,
                        dropdownColor: Colors.white, // Background color of the popup list
                        borderRadius: BorderRadius.circular(20), // Rounded corners for the popup list
                        elevation: 4, // Shadow for the popup list

                        // 4. Styling the Text inside
                        style: const TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        ),

                        // 5. Customizing the Icon (Arrow)
                        icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.purple),
                        iconSize: 30,

                        decoration: InputDecoration(
                          // Background color of the BUTTON (not the menu)
                          filled: true,
                          fillColor: Colors.purple.shade50,

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15), // Rounded corners for the button
                            borderSide: BorderSide.none, // specific border style
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                        ),

                        value: _selectedChapter, // Use 'value' instead of 'initialValue' when using state
                        items: chapters.map((chapter) {
                          return DropdownMenuItem(
                              value: chapter,
                              child: Text("Chapter $chapter") // Added "Chapter" for better look
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedChapter = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildActionButton(aiState),
                  ],
                )
            ),
            const SizedBox(height: 10),
            if (hasQuestions)
              Expanded(
                child: aiState.when(
                  data: (questions) => ListView.builder(
                    itemCount: questions.length,
                    itemBuilder: (_, i) =>
                        QuestionCard(question: questions[i]),
                  ),
                  loading: () => const SizedBox(),
                  error: (_, __) => const SizedBox(),
                ),
              ),


          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(AsyncValue<List<Question>> aiState) {
    if (aiState.isLoading) {
      return _disabledButton('Generating...');
    }

    if (aiState.hasError) {
      return _actionButton(
        label: 'Retry',
        color: Colors.grey,
        onTap: _generate,
      );
    }

    return _actionButton(
      label: 'Generate',
      color: Colors.purple,
      onTap: _generate,
    );
  }

  void _generate() {
    final selectedSubject = ref.read(selectedSubjectProvider);
    final subject = selectedSubject?.apiKey ?? '';
    ref.read(aiQuestionViewmodelProvider.notifier).fetchAiQuestion(
      topic: subject,
      chapter: _selectedChapter,
    );
  }

  Widget _actionButton({
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(label, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _disabledButton(String label) {
    return Container(
      height: 48,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }
}



