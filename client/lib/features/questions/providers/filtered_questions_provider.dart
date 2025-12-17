import 'package:client/features/questions/providers/question_type_filter_provider.dart';
import 'package:client/features/questions/viewmodel/question_viewmodel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/hive/models/question_model.dart';
import '../../subject/domain/subject.dart';
import '../../subject/providers/selected_subject_provider.dart';
import './marks_filter_provider.dart';

part 'filtered_questions_provider.g.dart';


@Riverpod(keepAlive: true)
Future<List<Question>> questionsBySubject(QuestionsBySubjectRef ref) async {
  // 1. Watch the raw data
  final questions = await ref.watch(questionViewmodelProvider.future);
  // 2. Watch the subject
  final selectedSubject = ref.watch(selectedSubjectProvider);

  if(selectedSubject == null) return questions;

  return questions.where((q) => q.subject == selectedSubject.apiKey).toList();
}



@Riverpod(keepAlive: true)
Future<List<Question>> filteredQuestions(FilteredQuestionsRef ref) async {
    final questions = await ref.watch(questionsBySubjectProvider.future);
    final marksFilter = ref.watch(marksFilterProvider);
    final questionTypeFilter = ref.watch(questionTypeFilterProvider);

          final data =  questions.where((question){
            print(question.subject);
            print("🔄 Filter Update Triggered!");

            // Filter 2: Marks
            if (marksFilter != 'All' && question.marks.toString() != marksFilter) {
              return false;
            }

            // Filter 3: Type
            if (questionTypeFilter != 'All' && question.questionType != questionTypeFilter) {
              return false;
            }

            return true;
          }).toList();

          data.sort((a,b) => a.marks - b.marks);
          return data;
}