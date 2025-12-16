import 'package:client/features/home/widget/stat_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodel/stat_viewmodel.dart';

class StatWidget extends ConsumerWidget {
  const StatWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statState = ref.watch(statViewmodelProvider);

    return statState.when(
      data: (stat) => Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StatInfoCard(backgroundColor: Color.fromARGB(255, 179, 247, 227), icon:  Icons.insert_drive_file_rounded, iconColor: Color.fromARGB(255, 26, 150, 136), text1: stat.paperCreated.toString(), text2: 'Papers Created'),
            StatInfoCard(text1: stat.totalQuestions.toString(), text2: 'Questions in\nbank', icon: Icons.question_answer, backgroundColor: Color.fromARGB(255, 239, 246, 255), iconColor: Color.fromARGB(255, 23, 95, 252)),
          ],
        ),
      ),
      error: (error, stackTrace) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Error: $error", style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () =>
                  ref.read(statViewmodelProvider.notifier).refresh(),
              child: const Text("Retry"),
            ),
          ],
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
