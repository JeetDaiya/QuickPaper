import 'package:client/features/questions/providers/selected_questions_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_question_info_provider.g.dart';

@riverpod
({int count, int marks}) selectedQuestionsInfo(
  SelectedQuestionsInfoRef ref,
) {
  final selected = ref.watch(selectedQuestionsProvider);
  final count = selected.length;
  final marks = selected.fold<int>(0, (sum, q) => sum += q.marks);
  return (count: count, marks: marks);
}
