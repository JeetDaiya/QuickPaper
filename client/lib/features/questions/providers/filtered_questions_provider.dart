import 'package:client/features/questions/providers/question_type_filter_provider.dart';
import 'package:client/features/questions/viewmodel/question_viewmodel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/hive/models/question_model.dart';
import './marks_filter_provider.dart';

part 'filtered_questions_provider.g.dart';

@riverpod
Future<List<Question>> filteredQuestions(FilteredQuestionsRef ref) async {
    final asyncQuestions = ref.watch(questionViewmodelProvider);
    final marksFilter = ref.watch(marksFilterProvider);
    final questionTypeFilter = ref.watch(questionTypeFilterProvider);

    return asyncQuestions.when(
        data: (questions){
          final data =  questions.where((question){
            bool matchedMarkFilter = question.marks.toString() == marksFilter || marksFilter == 'All';
            bool matchedTypeFilter = question.questionType == questionTypeFilter || questionTypeFilter == 'All';

            return matchedMarkFilter && matchedTypeFilter;
          }).toList();

          data.sort((a, b) => a.marks - b.marks);
          return data;
        },
        error: (e, st)=> [],
        loading: () => []
    );

}