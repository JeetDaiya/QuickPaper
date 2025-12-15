import 'dart:ui';
import 'package:client/features/questions/providers/selected_questions_provider.dart';
import 'package:client/features/questions/services/pdf/sectioned_pdf_service.dart';
import 'package:client/features/questions/view/pdf_preview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/pdf.dart';
import '../../../core/theme/app_pallete.dart';
import '../providers/selected_question_info_provider.dart';
import '../widgets/question_tag.dart';

class SelectedQuestionsPreviewScreen extends ConsumerWidget {
  const SelectedQuestionsPreviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedQuestionsInfo = ref.watch(selectedQuestionsInfoProvider);
    final selectedQuestions = ref.watch(selectedQuestionsProvider);

    return Scaffold(
      appBar: selectedQuestionsInfo.count > 0
          ? AppBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Paper Preview'),
                  Row(
                    children: [
                      Text(
                        '${selectedQuestionsInfo.count} Questions',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      Text(
                        ' • ',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      Text(
                        '${selectedQuestionsInfo.marks} Marks',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : null,
      body: selectedQuestionsInfo.count == 0
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xFFE5E7EB),
                    child: Icon(
                      Icons.not_interested_outlined,
                      color: Color(0xFF9AA0A6),
                      size: 50,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text('No Questions Selected', style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 10),
                  Text(
                    'Add questions from the Question Bank to create your paper',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () => {Navigator.of(context).pop()},
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Pallete.primaryColor),
                      padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder( borderRadius: BorderRadius.circular(10) ))
                    ),
                    child: Text(
                      'Go to Questions Bank',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w300
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '💡 Drag questions to reorder. ',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
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
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: ReorderableDragStartListener(
                                  index: index,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.drag_indicator_outlined,
                                          color: Colors.grey,
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Question ${index + 1}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: Colors.grey[600],
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Wrap(
                                                    spacing: 6,
                                                    children: [
                                                      QuestionTag(
                                                        question: question,
                                                        backgroundColor:
                                                            const Color(
                                                              0xFFE0F2F1,
                                                            ),
                                                        textColor: const Color(
                                                          0xFF00695C,
                                                        ),
                                                        info:
                                                            "${question.marks} Marks",
                                                      ),
                                                      QuestionTag(
                                                        question: question,
                                                        backgroundColor:
                                                            const Color(
                                                              0xFFECEFF1,
                                                            ),
                                                        textColor: const Color(
                                                          0xFF475569,
                                                        ),
                                                        info: question
                                                            .questionType,
                                                      ),
                                                    ],
                                                  ),
                                                  IconButton(
                                                    icon: const Icon(
                                                      Icons.delete_outline,
                                                    ),
                                                    color: Colors.redAccent,
                                                    onPressed: () {
                                                      ref
                                                          .read(
                                                            selectedQuestionsProvider
                                                                .notifier,
                                                          )
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
                                ),
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
      bottomNavigationBar: selectedQuestionsInfo.count > 0
          ? SafeArea(
              child: Container(
                height: 100,
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: Colors.grey, width: 2.0),
                  ),
                ),
                child: TextButton(
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    ),
                    backgroundColor: WidgetStateProperty.all(
                      Pallete.primaryColor,
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                    onPressed: () {
                      final sectionedPdfService = SectionedPdfService();
                      final selectedQuestions = ref.read(selectedQuestionsProvider);
                      final pdfData = sectionedPdfService.generate(PdfPageFormat.a4, selectedQuestions);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PdfPreviewScreen(
                            pdfData: pdfData,
                            title: 'Question Paper Preview',
                          ),
                        ),
                      );
                    },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.save_alt_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Save Paper',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : null,
    );
  }

  Widget _proxyDecorator(Widget child, int index, Animation<double> animation) {
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
