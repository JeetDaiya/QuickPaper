import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/hive/models/question_model.dart';

part 'selected_questions_provider.g.dart';


enum SelectionResult{
    added,
    removed,
    limitExceeded,
}

const int totalMarks = 108;

@Riverpod(keepAlive: true)
class SelectedQuestions extends _$SelectedQuestions {
@override
List<Question> build() => [];

int get _currentMarks =>
    state.fold(0, (sum, q) => sum + q.marks);



SelectionResult toggle(Question question){
  if(state.contains(question)){
    state = state.where((element) => element != question).toList();
    return SelectionResult.removed;
  }
  if(_currentMarks + question.marks > totalMarks){
    return SelectionResult.limitExceeded;
  }

  state = [...state, question];
  return SelectionResult.added;
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