import 'package:client/core/hive/models/question_model.dart';

class PaperSection {
  final String title;
  final String sectionInstruction;
  final bool Function(Question q) matcher;

  PaperSection({
    required this.title,
    required this.sectionInstruction,
    required this.matcher,
  });
}
