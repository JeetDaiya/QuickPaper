import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'marks_filter_provider.g.dart';


@riverpod
class MarksFilter extends _$MarksFilter {
@override
String build()=> "All";

void set(String marks){
  state = marks;
}
}
