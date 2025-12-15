import 'package:client/features/questions/viewmodel/question_viewmodel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'marks_options_provider.g.dart';

@riverpod
List<String> marksOptions(MarksOptionsRef ref) {
  final asyncQuestions = ref.watch(questionViewmodelProvider);

  return asyncQuestions.maybeWhen(
    data: (questions) {
      final marks = questions
          .map((q) => q.marks.toString())
          .toSet()
          .toList()
        ..sort();
      marks.insert(0, 'All');
      return marks;
    },
    orElse: () => [],
  );
}
