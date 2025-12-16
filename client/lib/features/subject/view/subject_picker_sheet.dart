import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/subject.dart';
import '../providers/selected_subject_provider.dart';
import '../../questions/view/selected_questions_preview_screen.dart';

class SubjectPickerSheet extends ConsumerWidget {
  const SubjectPickerSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Select Subject',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...Subject.values.map(
                (subject) => ListTile(
              title: Text(subject.label),
              onTap: () {
                ref
                    .read(selectedSubjectProvider.notifier)
                    .select(subject);
                Navigator.pop(context); // close sheet
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SelectedQuestionsPreviewScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
