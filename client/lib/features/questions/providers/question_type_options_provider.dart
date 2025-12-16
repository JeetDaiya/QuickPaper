import 'package:client/features/questions/viewmodel/question_viewmodel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/utils/question_type_map.dart';
import 'package:client/core/hive/models/question_model.dart';

part 'question_type_options_provider.g.dart';

@riverpod
List<String> questionTypeOptions(QuestionTypeOptionsRef ref) {
  final asyncQuestions = ref.watch(questionViewmodelProvider);

  return asyncQuestions.maybeWhen(
    data: (questions) {
      final type = questions
          .map((q) => q.questionType)
          .toSet()
          .toList()
        ..sort();
      type.insert(0, 'All');
      return type;
    },
    orElse: () => [],
  );
}
