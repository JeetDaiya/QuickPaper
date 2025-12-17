import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'paper_flow_provider.g.dart';

enum PaperStep {
  selectSubject,
  selectQuestions,
  preview,
}

@riverpod
class PaperFlow extends _$PaperFlow {
@override
PaperStep build() => PaperStep.selectSubject;

void goToQuestions() => state = PaperStep.selectQuestions;
void goToPreview() => state = PaperStep.preview;
void goToSubject() => state = PaperStep.selectSubject;
}
