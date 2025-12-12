import 'package:client/features/questions/viewmodel/question_viewmodel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/hive/models/question_model.dart';
import './marks_filter_provider.dart';

part 'filtered_questions_provider.g.dart';

@riverpod
Future<List<Question>> filteredQuestions(FilteredQuestionsRef ref) async {
    final asyncQuestions = ref.watch(questionViewmodelProvider);
    final marksFilter = ref.watch(marksFilterProvider);

    return asyncQuestions.when(
        data: (questions){
            return questions.where((question){
                bool matchedMarkFilter = question.marks.toString() == marksFilter || marksFilter == 'All';
                return matchedMarkFilter;
            }).toList();
        },
        error: (e, st)=> [],
        loading: () => []
    );

}