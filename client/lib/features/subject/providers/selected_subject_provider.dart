import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/subject.dart';

part 'selected_subject_provider.g.dart';

@riverpod
class SelectedSubject extends _$SelectedSubject {
@override
Subject? build() => null;
  void select(Subject subject){
    state = subject;
  }

  void clear(){
      state = null;
  }
}
