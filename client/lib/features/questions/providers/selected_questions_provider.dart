import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/hive/models/question_model.dart';

part 'selected_questions_provider.g.dart';


@Riverpod(keepAlive: true)
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

void reorder(int oldIndex, int newIndex) {
  final updated = [...state];
  final item = updated.removeAt(oldIndex);
  updated.insert(newIndex, item);
  state = updated;
}


void clear(){
  state = [];
}

}