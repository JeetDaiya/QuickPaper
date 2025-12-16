import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'question_type_filter_provider.g.dart';

@riverpod
class QuestionTypeFilter extends _$QuestionTypeFilter {
@override
String build () => "All";

void set(String type){
  state = type;
}

}