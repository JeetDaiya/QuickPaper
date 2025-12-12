import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/hive/models/question_model.dart';

part 'selected_questions_provider.g.dart';

@riverpod
class SelectedQuestions extends _$SelectedQuestions {
@override
List<Question> build() => [];

void toggle(Question question){
  if(state.contains(question)){
    state = state.where((element) => element != question).toList();
  }else{
    state = [...state, question];
  }
}

void clear(){
  state = [];
}

}