import 'package:client/core/hive/models/question_model.dart';
import 'package:client/features/questions/repositories/questions_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'question_viewmodel.g.dart';

@riverpod
class QuestionViewmodel extends _$QuestionViewmodel {

  @override
  FutureOr<List<Question>>build() async{
      return _fetchData();
  }

  Future<List<Question>>_fetchData() async{
    final questions = await ref.watch(questionRepositoryProvider).getQuestions();
    return questions;
  }
  Future<void>refresh() async{
    state = const AsyncValue.loading();
    state = AsyncValue.data(await _fetchData());
  }
}