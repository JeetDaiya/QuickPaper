import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/subject.dart';
import '../providers/selected_subject_provider.dart';

class SubjectPickerSheet extends ConsumerWidget {
  const SubjectPickerSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Get the list of data once
    final subjects = Subject.values;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Hug content height
        children: [
          const Text(
            'Select Subject',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // 2. The Grid Structure
          GridView.builder(
            shrinkWrap: true, // Vital for nesting inside Column/BottomSheet
            physics: const NeverScrollableScrollPhysics(), // Disable internal scrolling
            itemCount: subjects.length,

            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,       // 2 items per row
              crossAxisSpacing: 12,    // Horizontal gap
              mainAxisSpacing: 12,     // Vertical gap
              childAspectRatio: 2.5,   // Width / Height ratio (Higher = flatter button)
            ),

            itemBuilder: (context, index) {
              final subject = subjects[index];

              return ElevatedButton(
                onPressed: () {
                  ref
                      .read(selectedSubjectProvider.notifier)
                      .select(subject);

                  Navigator.pop(context, subject);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Fixed size Icon
                    Image.asset(
                      'assets/images/${subject.apiKey}_logo.png',
                      width: 30,  // Explicit width (replaces 'size')
                      height: 30, // Explicit height
                      fit: BoxFit.contain, // Ensures it doesn't get cropped
                    ),
                    Text(
                      subject.label,
                      style: const TextStyle(fontSize: 14), // Adjust text size to fit
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}