import 'package:client/core/hive/models/question_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:client/features/questions/services/ai/ai_question_service.dart';

part 'ai_question_viewmodel.g.dart';

@riverpod
class AiQuestionViewmodel extends _$AiQuestionViewmodel {
  final AiQuestionService _aiQuestionService = AiQuestionService();
  @override
  FutureOr<List<Question>> build() async {
    return [];
  }

  Future<void>fetchAiQuestion({required String topic, required String chapter}) async{
     state = AsyncValue.loading();
     try{
       final questions = await _aiQuestionService.generateAiQuestion(topic: topic, chapter: chapter);
        state = AsyncData(questions);
     }
     catch(error){
       print(error);
       state = AsyncError(error, StackTrace.current);
     }
  }

}